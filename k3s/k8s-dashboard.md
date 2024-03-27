# Setup k8s dashboard
Intended only for a quick test, not for permanent use.

## Prerequisites
* running k3s
* on remote host that is reachable via ssh

## Get the k8s dashboard

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
```

## Setup permissions

Create a file named `service-account.yaml` with the following contents:
```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
```

Create a file named `cluster-role.yaml` with the following contents:
```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
```

And apply the two files:
```
kubectl apply -f service-account.yaml
kubectl apply -f cluster-role.yaml
```

Finally create a token to be able to login:
```
create token admin-user -n kubernetes-dashboard
```
Copy the returned string (which is a JWT). The token is typically valid for 1 hour.

## Setup proxy and ssh tunnel

On the host running k3s:
```
kubectl proxy
```

On the remote machine:
```
ssh -N -L localhost:8001:localhost:8001 <user>@<k3s-host>
```

## Login finally

Navigate to http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login and enter the value of the token.
