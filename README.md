# doks-template
Example manifests & terraform for DOKS (DigitalOcean Kubernetes Service)

Nothing fancy - just saving some stuff I wrote for DOKS. Will cleanup later

Things to find and replace:
- template.com

After that, run 
```
make deploy
```

Project uses AWS S3 to store backend state, and DOKS to deploy K8s cluster. Update backend settings if you don't want to use S3.

This is something that I am working on, so currently not intended for usage

Things to follow:
- backend app with Dockerfile
- frontend app with Dockerfile
- Github actions
