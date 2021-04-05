#Kubeadm Baremetal Installation
#--------------------------------

# K8 - Kubeadm for Ubuntu Installation - Both Master and worker nodes should be installed with these steps.
#----------------------------------------------------------------------------------------------------------
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
#sudo apt-mark hold kubelet kubeadm kubectl


#Creating Kubeadm cluster Initialization and Cluster creation, execute below commands on master
#----------------------------------------------------------------------------------------------
#--apiserver-advertise-address=<Ec2 Private IP address>
#Ignore preflight errors (--ignore-preflight-errors=NumCPU)
#--cluster-cidr=<your-pod-cidr> and --allocate-node-cidrs=true
kubeadm init --apiserver-advertise-address=10.1.0.204 --pod-network-cidr=192.168.0.0/16
kubeadm init --apiserver-advertise-address=10.1.0.165 --pod-network-cidr=192.168.0.0/16


#Execute below command on Worker node to connect with Master nodes
#------------------------------------------------------------------
#kubeadm token list
#kubeadm token create
kubeadm join 10.1.0.204:6443 --token  8vk000.3czq6mkle049pyd5 --discovery-token-ca-cert-hash sha256:d292fcb9f3d2e75cfaf8b2fcde92a3d8f424ec72d1e1b3cc59d77ebde4aec197

#Execute below commands in master
#---------------------------------
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl get nodes

#Download the flannel networking manifest for the Kubernetes API datastore
#--------------------------------------------------------------------------
curl https://docs.projectcalico.org/manifests/canal.yaml -O


#Install Network Plugin (Calico)
#-------------------------------
kubectl apply -f canal.yaml

#Install k8 control plan on localhost
#-------------------------------------
#For Cluster IP Expose
    #kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
    kubectl proxy
    nohup kubectl proxy > /tmp/log.out  2>&1 &

    http://54.205.72.13:32323/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
    http://3.239.78.251:32323/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
    kubectl get secrets
    kubectl describe secret dashboard-admin-sa-token-kw7vn
#For Nodeport Expose
    #kubectl -n kubernetes-dashboard get all
    #kubectl -n kubernetes-dashboard describe svc kubernetes-dashboard
    #kubectl -n kubernetes-dashboard edit svc kubernetes-dashboard
    #Change the ClusterIP to NodePort:32323
    #kubectl -n kubernetes-dashboard get svc 
    #kubectl get nodes -o wide
    #kubectl -n kube-system get services
    #lsof -i tcp:32323 # this will open the port in Ubuntu
    #lsof -i tcp:32760 # this will open the port in Ubuntu
    #lsof -i tcp:32761 # this will open the port in Ubuntu
    #lsof -i tcp:32763 # this will open the port in Ubuntu
#Access Below site from any browser
    https://54.205.72.13:32323
    #Paste Below Token
    #-----------------
    #eyJhbGciOiJSUzI1NiIsImtpZCI6InpuOWlBNERFZnI3andaeC14ZTdveko4aVJCUUFNN29iMmxuMXBjYmhlOTgifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4tc2M2c3giLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjVmMjgxMjg1LWMzOTctNDNjZC05Y2UzLTkzYzk5Y2E3ZTJjNiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.aU4chuLeqkAAOphMtyDWYRjbUHzYcVQcF2lQvfy2sdTvaFRl2w4ELz2bozpbN2oXRKdRPPBdQGMwkoAkhOfiEDam1hHtOgVhy5Ub1M4eS0ArP6rkX8geEsVqpuP11xIvLFaonpe1_TcjQiO614lrFHLuYeDtOV9APv1pFET_Bnsq101Qy7FDvYSDS66XU9LvxDEEOKRDLwjC0KBw7s2TN1unSukvaDFt0JNyIc2-uKEhtuP_8gfEWLPNdvVi0rOBhYAehu9enWLZg1KPs5Lg7nT470CPWgsIvzr4qQIFKsgYRtVZydaer_UiKJSQnZXz0-S_jiXBxIOBIhJi7yg2nQ

    https://3.239.78.251:32323 (Dynamic Public IP, need to change if you restart your machine)
    #Paste Below Token
    #-----------------
    #eyJhbGciOiJSUzI1NiIsImtpZCI6Ilp2dU82alFLQXJvc1BuQk51N3FCa0tiTFlwN2RIbnQzQ1NtLWhnWE8tOG8ifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4tZmg3amoiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjZjNTQ4YmFlLTFkYmItNDNhZi1iMzMzLTViMzNjOTc2ZjdjYSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.XnP349uMmfhqWJMcib1xCy-rfrtylZbZupy0R5GWOmezIxQNb4p-ZlkGvYnwPOrX7Z8u0nLeaEvIOOT8hgK-4QFlPRFVlbmVUJ31e5x4hu-XgA_UFTrJHLLEaBSTcSUgINgsaSYS9_3NwLKFvUrM1TqRY8_mExtN2APNoIRcSgM1KI2TVfyVdcvBvf-ZFaRlfeD54lDbHtmS15kwoXEPvm3RG6fzEWIwld0uQfetY12TCzIBz1EkwAuE31lOSzQsUlqR-4To7vZ1ss3WcZUMcKaZt1CIC26N0q6-jZpYdeZPRXhUUh5tywWMohJfhwjkgISbXAnczCSBuumqKL7Vig

#Provide component create access to service account user of of K8 cluster by executing below command on K8 Master node.
    kubectl create clusterrolebinding serviceaccounts-cluster-admin \
    --clusterrole=cluster-admin \
    --group=system:serviceaccounts

#Execute below flip command on Master K8 node to remove the taint and schedule the pod on master node
    kubectl taint nodes $(hostname) node-role.kubernetes.io/master:NoSchedule-
    kubectl taint nodes $(hostname) node-role.kubernetes.io/master:NoSchedule
    kubectl describe node $(hostname)

#Execute below resource quota and limit range on master node reserve the resources to deploy the PODs and deployments.
    #Resource Quota
    # apiVersion: v1
    # kind: ResourceQuota
    # metadata:
    #   name: compute-resources
    # spec:
    #   hard:
    #     pods: "30" 
    #     requests.cpu: "1" 
    #     requests.memory: 3Gi 
    #     requests.ephemeral-storage: 5Gi 
    #     limits.cpu: "2" 
    #     limits.memory: 4Gi 
    #     limits.ephemeral-storage: 6Gi
    
    # #Limit Range
    # apiVersion: v1
    # kind: LimitRange
    # metadata:
    #     name: mem-limit-range
    # spec:
    #     limits:
    #     - default:
    #         memory: 512Mi
    #     defaultRequest:
    #         memory: 256Mi
    #     type: Container
#To modify the resource quota: kubectl edit resourcequota compute-resources


#To increase the AWS volume size and allocate the increased volume to root disk and partition.    
    df -hT
    lsblk
    sudo growpart /dev/nvme0n1 1


#Use below command To Connect with AWS ECR to pull deep learning images
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 763104351884.dkr.ecr.us-east-1.amazonaws.com

#Use below command To pull AWS tensor flow image from ECR regsitry
763104351884.dkr.ecr.us-east-1.amazonaws.com/tensorflow-training:2.2.0-cpu-py37-ubuntu18.04-v1.0

