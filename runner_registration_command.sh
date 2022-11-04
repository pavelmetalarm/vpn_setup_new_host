#Command to register runner
#!/bin/bash
REGISTRATION_TOKEN="TsngXNbDomsUzq-gxNbf"
sudo gitlab-runner register --url https://gitlab.com/ --registration-token $REGISTRATION_TOKEN
