# eks-cluster
Eks cluster with terraform

Create Key Pair for remotely access our worker nodes.

```
 aws ec2 create-key-pair --key-name EKS-Key --query 'KeyMaterial' --output text | out-file -encoding ascii -filepath EKS-Key.pem
```
