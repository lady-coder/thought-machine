enableUI: true
enableDEX: true
region: ${region}
regionEcr: ${region_ecr}
githubOAuthAppSecretName: ${githubOAuthAppSecretName}
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
        type: git
        url: https://github.com/${githubOrg}
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
    nodeSelector:
      Type: system

    tolerations:
      - key: "node-group"
        operator: "Equal"
        value: "system"
        effect: "NoExecute"

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
      maxReplicas: 3
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
      maxReplicas: 5
    resources:
      limits:
        cpu: 400m
        memory: 256Mi
      requests:
        cpu: 200m
        memory: 256Mi
    ingress:
      enabled: true
      annotations:
        kubernetes.io/ingress.class: alb
        alb.ingress.kubernetes.io/subnets: ${subnetIDs}
        alb.ingress.kubernetes.io/wafv2-acl-arn: ${wafArn}
        alb.ingress.kubernetes.io/certificate-arn: ${certificateArn}
        alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS": 443}]'
        alb.ingress.kubernetes.io/ssl-policy: ELBSecurityPolicy-FS-1-2-Res-2019-08
        alb.ingress.kubernetes.io/target-type: ip
        alb.ingress.kubernetes.io/scheme: internet-facing
        alb.ingress.kubernetes.io/healthcheck-path: /healthz
        alb.ingress.kubernetes.io/backend-protocol: HTTPS
        alb.ingress.kubernetes.io/healthcheck-protocol: HTTPS
        alb.ingress.kubernetes.io/healthcheck-port: traffic-port
        alb.ingress.kubernetes.io/security-groups: ${securityGroup}
      hosts:
        - ${domainName}
    rbacConfig:
      policy.default: role:developer
      policy.csv: |-
        p, role:developer, applications, get, applications/*, allow
        p, role:developer, certificates, get, *, deny
        p, role:developer, clusters, get, *, allow
        p, role:developer, repositories, get, *, allow
        p, role:developer, projects, get, applications, allow
        p, role:developer, accounts, get, *, deny
        p, role:developer, gpgkeys, get, *, deny
        %{ for team, repos in repositories ~}
        %{ for repo in repos ~}
        p, role:${team}, applications, sync, applications/${repo}, allow
        %{ endfor ~}
        g, role:${team}, role:developer
        g, ${githubOrg}:${team}, role:${team}
        %{ endfor ~}
        g, ${githubOrg}:cloud_platform_devops_team, role:admin
    config:
      admin.enabled: "true"
      url: https://${domainName}
      dex.config: |-
        logger:
          level: debug
        connectors:
        - type: github
          id: github
          name: GitHub
          config:
            clientID: ${githubOAuthAppClientID}
            clientSecret: $dex.github.clientSecret
            loadAllGroups: true
            orgs:
            - name: ${githubOrg}
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
