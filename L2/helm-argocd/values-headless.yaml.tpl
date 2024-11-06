enableUI: false
enableDEX: false
region: ${region}
regionEcr: ${region_ecr}
githubAppPrivateKey: ${githubAppPrivateKey}
sharedServicesAccountId: "${shared_services_account_id}"

argo-cd:

  global:
    image:
      repository: ${shared_services_account_id}.dkr.ecr.${region_ecr}.amazonaws.com/platform/images/argocd
      tag: ${argocd_version}

  configs:
    credentialTemplates:
      github-enterprise-creds:
        githubAppID: ${githubAppID}
        githubAppInstallationID: "${githubAppInstallationID}"
        githubAppPrivateKey: CHANGEME

  controller:
    enableStatefulSet: true
    logLevel: warn

    nodeSelector:
      Type: system

    tolerations:
      - key: "node-group"
        operator: "Equal"
        value: "system"
        effect: "NoExecute"

  dex:
    enabled: false

  redis:
    image:
      repository: ${shared_services_account_id}.dkr.ecr.${region_ecr}.amazonaws.com/platform/images/redis
      tag: ${redis_version}

    nodeSelector:
      Type: system

    tolerations:
      - key: "node-group"
        operator: "Equal"
        value: "system"
        effect: "NoExecute"

  repoServer:
    autoscaling:
      enabled: true
      minReplicas: 1
      maxReplicas: 5
    resources:
      limits:
        cpu: 400m
        memory: 256Mi
      requests:
        cpu: 200m
        memory: 256Mi
    logLevel: warn
    serviceAccount:
      create: true
      name: "argocd-repo-server"
      automountServiceAccountToken: true

    nodeSelector:
      Type: system

    tolerations:
      - key: "node-group"
        operator: "Equal"
        value: "system"
        effect: "NoExecute"

  notifications:
    nodeSelector:
      Type: system

    tolerations:
      - key: "node-group"
        operator: "Equal"
        value: "system"
        effect: "NoExecute"

  applicationSet:

    nodeSelector:
      Type: system

    tolerations:
      - key: "node-group"
        operator: "Equal"
        value: "system"
        effect: "NoExecute"

  server:
    autoscaling:
      enabled: true
      minReplicas: 1
      maxReplicas: 3
    resources:
      limits:
        cpu: 400m
        memory: 256Mi
      requests:
        cpu: 200m
        memory: 256Mi
    ingress:
      enabled: false
    rbacConfig:
      policy.default: role:admin
    config:
      admin.enabled: "true"
    logLevel: warn

    nodeSelector:
      Type: system

    tolerations:
      - key: "node-group"
        operator: "Equal"
        value: "system"
        effect: "NoExecute"

    affinity:
      podAntiAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
        - labelSelector:
            matchExpressions:
            - key: app.kubernetes.io/name
              operator: In
              values:
              - argocd-server
          topologyKey: "kubernetes.io/hostname"
