<h3>a) create Azure Service Principal:</h3>

 0.1 get SUBSCRIPTION_ID<br>
 <b>$ az login</b><br>
 #"id": -- SUBSCRIPTION_ID<br>
 
0.2 create the Service Principal which will have permissions to manage resource1s in the specified subscription using the following command:<br>
 <b># az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"</b>

 <br>appId is the CLIENT_ID defined above.
 <br>password is the CLIENT_SECRET defined above.
 <br>tenant is the TENANT_ID defined above.
 
 0.3 login as Service Principal<br>
 <b># az login --service-principal -u CLIENT_ID -p CLIENT_SECRET --tenant TENANT_ID</b>
 
 
<h3>1.create Structure:</h3>

<b>main.tf</b> - Declare the Azure provider
   (actually its provider "azurerm")
   
<b>k8s.tf</b>  - Define a Kubernetes cluster
  - create resource_group
  - create azurerm_kubernetes_cluster (set the name of the claster, location, FQDN)
  
 <b>variables.tf</b> -  Declare the variables
  agent_count,dns_prefix,cluster_name, resource_group_name and location are set there 
 
 <b>output.tf</b> - define values that will be highlighted to the user when Terraform applies a plan
 
 <h3>2. use the <b>terraform init</b> command to create the resources defined in the configuration files you created</h3>
   <b># terraform init</b>
   
   2.2 Export your service principal credentials. Replace the placeholders with appropriate values from your service principal.<br>
   export TF_VAR_client_id= (service-principal-appid)<br>
   export TF_VAR_client_secret=(service-principal-password) 
   
  <h3>3. Run the <b>terraform plan</b> command to create the Terraform plan that defines the infrastructure elements.</h3>
   <b># terraform plan</b>
  <h3>4. Run the <b>terraform apply</b> command to apply the plan to create the Kubernetes cluster</h3>
   <b># terraform apply</b>
  <h3>5. Test the Kubernetes cluster</h3>
    <b>kubectl get nodes</b>
    
  <h3>6.Destroy Infrastructure  </h3>
   <b>terraform destroy </b>
