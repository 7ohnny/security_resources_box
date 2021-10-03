notes.md

source: https://www.aquasec.com/cloud-native-academy/kubernetes-in-production/kubernetes-security-best-practices-10-steps-to-securing-k8s/

1. Enable Kubernetes Role-Based Access Control (RBAC)
RBAC can help you define who has access to the Kubernetes API and what permissions they have. RBAC is usually enabled by default on Kubernetes 1.6 and higher (later on some hosted Kubernetes providers). Because Kubernetes combines authorization controllers, when you enable RBAC, you must also disable the legacy Attribute Based Access Control (ABAC).

When using RBAC, prefer namespace-specific permissions instead of cluster-wide permissions. Even when debugging, do not grant cluster administrator privileges. It is safer to allow access only when necessary for your specific situation.

Learn more in our guide to Kubernetes RBAC ›

2. Use Third-Party Authentication for API Server
It is recommended to integrate Kubernetes with a third-party authentication provider (e.g. GitHub). This provides additional security features such as multi-factor authentication, and ensures that kube-apiserver does not change when users are added or removed. If possible, make sure that users are not managed at the API server level. You can also use OAuth 2.0 connectors like Dex.

3. Protect etcd with TLS, Firewall and Encryption
Since etcd stores the state of the cluster and its secrets, it is a sensitive resource and an attractive target for attackers. If unauthorized users gain access to etcd they can take over the entire cluster. Read access is also dangerous because malicious users can use it to elevate privileges.

To configure TLS for etcd for client-server communication, use the following configuration options:

cert-file=: Certificate used for SSL/TLS connection with etcd
--key-file=: Certificate key (not encrypted)
--client-cert-auth: Specify that etcd should check incoming HTTPS requests to find a client certificate signed by a trusted CA
--trusted-ca-file=<path>: Trusted certification authority
--auto-tls: Use self-signed auto-generated certificate for client connections
To configure TLS for etcd for server-to-server communication, use the following configuration options:

--peer-cert-file=<path>: Certificate used for SSL/TLS connections between peers
--peer-key-file=<path>: Certificate key (not encrypted)
--peer-client-cert-auth: When this option is set, etcd checks for valid signed client certificates on all incoming peer requests
--peer-trusted-ca-file=<path>: Trusted certification authority
--peer-auto-tls: Use auto-generated self-signed certificates for peer-to-peer connections
Also, set up a firewall between the API server and the etcd cluster. For example, run etcd on a separate node and use Calico to configure a firewall on that node.

Turn on encryption at rest for etcd secrets:

Encryption is crucial for securing etcd, and is not turned on by default. You can enable it via kube-apiserver process, by passing the argument –encryption-provider-config. Within the configuration, you’ll need to select a provider to perform encryption, and define your secret keys. See the documentation for more details.

4. Isolate Kubernetes Nodes
Kubernetes nodes must be on a separate network and should not be exposed directly to public networks. If possible, you should even avoid direct connections to the general corporate network. 

This is only possible if Kubernetes control and data traffic are isolated. Otherwise, both flow through the same pipe, and open access to the data plane implies open access to the control plane. Ideally, nodes should be configured with an ingress controller, set to only allow connections from the master node on the specified port through the network access control list (ACL).

5. Monitor Network Traffic to Limit Communications
Containerized applications generally make extensive use of cluster networks. Observe active network traffic and compare it to the traffic allowed by Kubernetes network policy, to understand how your application interacts and identify anomalous communications.

At the same time, if you compare active traffic to allowed traffic, you can identify network policies that are not actively used by cluster workloads. This information can be used to further strengthen the allowed network policy, removing unneeded connections to reduce the attack surface.

6. Use Process Whitelisting
Process whitelisting is an effective way to identify unexpected running processes. First, observe the application over a period of time to identify all processes running during normal application behavior. Then use this list as your whitelist for future application behavior.

It is difficult to do runtime analysis at the process level. Several commercial security solutions are available that can help analyze and identify anomalies in running processes across clusters.

7. Turn on Audit Logging
Make sure that audit logging is enabled and you are monitoring unusual or unwanted API calls, especially authentication failures. These log entries display a “Forbidden” status message. Failure to authorize could mean that an attacker is trying to use stolen credentials. 

When passing files to kube-apiserver, you can use the –audit-policy-file flag to turn on audit logging, and also define exactly which events should be logged. You can set one of four logging levels – None, Metadata only, Request which logs metadata and request but not responses, and RequestResponse which logs all three. For an example of an audit policy file, see the documentation.

Managed Kubernetes providers can provide access to this data in their console, and set up notifications for authorization failures.

8. Keep Kubernetes Version Up to Date
You should always run the latest version of Kubernetes. A list of known Kubernetes vulnerabilities with severity scores can be found here. 

Always plan to upgrade your Kubernetes version to the latest available version. Upgrading Kubernetes can be a complex process; if you are using a hosted Kubernetes provider, check if your provider handles automatic upgrades.

9. Lock Down Kubelet
The kubelet is an agent running on each node, which interacts with container runtime to launch pods and report metrics for nodes and pods. Each kubelet in the cluster exposes an API, which you can use to start and stop pods, and perform other operations. If an unauthorized user gains access to this API (on any node) and can run code on the cluster, they can compromise the entire cluster.

Here are configuration options you can use to lock the kubelet and reduce the attack surface:

Disable anonymous access with --anonymous-auth=false so that unauthenticated requests get an error response. To do this, the API server needs to identify itself to the kubelet. This can be set by adding the flags -kubelet-clientcertificate and --kubelet-client-key.
Set --authorization mode to a value other than AlwaysAllow to verify that requests are authorized. By default, the kubeadm installation tool sets this as a webhook, ensuring that kubelet calls SubjectAccessReview on the API server for authentication.
Include NodeRestriction in the API server –admission-control setting, to restrict kubelet permissions. This only allows the kubelet to modify pods bound to its own node object.
Set --read-only-port=0 to close read-only ports. This prevents anonymous users from accessing information about running workloads. This port does not allow hackers to control the cluster, but can be used during the reconnaissance phase of an attack.
Turn off cAdvisor, which was used in old versions of Kubernetes to provide metrics, and has been replaced by Kubernetes API statistics. Set -cadvisor-port=0 to avoid exposing information about running workloads. This is the default setting for Kubernetes v1.11. If you need to run cAdvisor, do so using a DaemonSet.
10. Secure Kubernetes with Aqua
Aqua tames the complexity of Kubernetes security with KSPM (Kubernetes Security Posture Management) and advanced agentless Kubernetes Runtime Protection. 

Aqua provides Kubernetes-native capabilities to achieve policy-driven, full-lifecycle protection and compliance for K8s applications:

Kubernetes Security Posture Management (KSPM) – a holistic view of the security posture of your Kubernetes infrastructure for accurate reporting and remediation. Helping you identify and remediate security risks.
Automate Kubernetes security configuration and compliance – identify and remediate risks through security assessments and automated compliance monitoring. Help you enforce policy-driven security monitoring and governance.
Control pod deployment based on K8s risk – determine admission of workloads across the cluster based on pod, node, and cluster attributes. Enable contextual reduction of risk with out-of-the-box best practices and custom Open Policy Agent (OPA) rules.
Protect entire clusters with agentless runtime security – runtime protection for Kubernetes workloads with no need for host OS access, for easy, seamless deployment in managed or restricted K8s environments.
Open Source Kubernetes Security – Aqua provides the most popular open source tools for securing Kubernetes, including Kube-Bench, which assesses Kubernetes clusters against 100+ tests of the CIS Benchmark, and Kube-Hunter, which performs penetration tests using dozens of known attack vectors.