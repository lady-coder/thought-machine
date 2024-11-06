
external-secrets:

  replicaCount: 1

  image:
    repository: ${shared_services_account_id}.dkr.ecr.${region_ecr}.amazonaws.com/platform/images/external-secrets
    tag: ${external_secrets_version}
    pullPolicy: IfNotPresent

  installCRDs: true

  crds:
    createClusterExternalSecret: false
    createClusterSecretStore: true
    createPushSecret: false
    conversion:
      enabled: true

  processClusterExternalSecret: false
  processClusterStore: true
  processPushSecret: false
  createOperator: true

  concurrent: 1

  serviceAccount:
    create: true
    automount: true
    annotations:
      eks.amazonaws.com/role-arn: ${irsa_role_arn}

  rbac:
    create: true
    servicebindings:
      create: true

  securityContext:
    allowPrivilegeEscalation: false
    capabilities:
      drop:
        - ALL
    readOnlyRootFilesystem: true
    runAsNonRoot: true
    runAsUser: 1000
    seccompProfile:
      type: RuntimeDefault

  resources:
    limits:
      cpu: 200m
      memory: 128Mi
    requests:
      cpu: 100m
      memory: 128Mi

  metrics:
    service:
      enabled: true
      port: 8080

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
            - external-secrets
        topologyKey: "kubernetes.io/hostname"
    
  webhook:
    create: true
    certCheckInterval: "5m"
    replicaCount: 1

    image:
      repository: ${shared_services_account_id}.dkr.ecr.${region_ecr}.amazonaws.com/platform/images/external-secrets
      tag: ${external_secrets_version}
      pullPolicy: IfNotPresent

    port: 10250

    rbac:
      create: true

    serviceAccount:
      create: true
      automount: true

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
              - external-secrets-webhook
          topologyKey: "kubernetes.io/hostname"

  certManager:
    enabled: false

  certController:
    create: true
    requeueInterval: "5m"
    replicaCount: 1

    image:
      repository: ${shared_services_account_id}.dkr.ecr.${region_ecr}.amazonaws.com/platform/images/external-secrets
      tag: ${external_secrets_version}
      pullPolicy: IfNotPresent

    rbac:
      create: true

    serviceAccount:
      create: true
      automount: true

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
              - external-secrets-cert-controller
          topologyKey: "kubernetes.io/hostname"

    metrics:
      service:
        enabled: true
        port: 8080

    readinessProbe:
      port: 8081

    securityContext:
      allowPrivilegeEscalation: false
      capabilities:
        drop:
          - ALL
      readOnlyRootFilesystem: true
      runAsNonRoot: true
      runAsUser: 1000
      seccompProfile:
        type: RuntimeDefault

    resources:
      limits:
        cpu: 200m
        memory: 128Mi
      requests:
        cpu: 100m
        memory: 128Mi
