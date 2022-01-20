#!/bin/bash

ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
FILE="./configs/kube-apiserver/encryption-config.yaml"

if [ ! -e $FILE ]; then
cat > ./configs/kube-apiserver/encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF
echo "---> Complete to generate encryption config"
else
echo "---> Could not generate encryption config"
fi

exit 0
