# W3F Platform

This repo contains files for creating and managing the infrastructure platform
upon which the rest of the components will run. It consist of terraform modules
to manage the actual cloud resources and scripts and CI/CD configuration files
for automating the process.

## Files

There are 3 main directories in the repo:

* `modules`: contains the terraform code to manage the platform cloud resources.
Currently it consists of a single module, `w3f`, which is configured to create a
managed Kubernetes cluster using Digital Ocean as cloud provider.

It uses a terraform backend for storing the cluster state, so that different
executions can refer to the same cluster without having to store the state files
on the git repository (see [Terraform backends](https://www.terraform.io/docs/backends/)
for details).

For the actual creation of the cluster take advantage of the `digitalocean_kubernetes_cluster`
resource, see [here](https://www.terraform.io/docs/providers/do/r/kubernetes_cluster.html)
for details.

* `scripts`: shell code to call terraform from the docker containers run by the
CI/CD provider.

The most important file is `deploy.sh`, which is used for initializing
the backend, applying the configuration and showing the configuration for accessing
the target cluster. It requires these environment variables:
    * `$TF_VAR_do_token`
    * `$SPACES_ACCESS_TOKEN`
    * `$SPACES_SECRET_KEY`
    * `$SPACES_BUCKET_NAME`
    * `$SPACES_ENDPOINT`
These values are set in the CI configuration and are accessible from the
`Infrastructure` vault on 1Password in an item called `DigitalOcean API credentials`.

* `.circleci`: contains the configuration files for the CI/CD provider, currently
CircleCI. This configuration defines

## Workflow

All the actions performed on the managed infrastructure components are triggered
by changes on this repo. When a PR is opened, CI runs a set of checks to verify
that the changes don't break the current functionality.

Once the PR is merged to master, the `scripts/deploy.sh` script is executed by CD,
and terraform checks the current state of the resources. Then determines if any
change is required to match the desired state, executing them if so.

## Cluster Access

The main target of the current module is a kubernetes cluster. For accessing it
we can use [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
The required configuration file is stored in the `Infrastructure` vault on
1Password in an item called `kubeconfig for w3f kubernetes cluster`. Once
downloaded and with `kubectl` installed, the cluster can be accessed with:
```
$ export KUBECONFIG=/path/to/kubeconfig-w3f.yaml
$ kubectl get pods --all-namespaces
```
For more information about `kubectl` see [here](https://kubernetes.io/docs/reference/kubectl/overview/).
