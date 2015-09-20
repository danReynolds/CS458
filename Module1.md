# 1.1 Computer Security

Assets include hardware, software, data, people, processes, and combinations of these.

**Threat** = set of circumstances that has the potential to cause harm to the system.


**Vulnerability** = weakness in the system that could be exploited to cause harm.

A threat is that someone could see you typing your password and later access your computer, stealing your data.

A vulnerability is that your password is printed in plaintext as you type it, so they are able to see it more easily and make good on their threat.

**Control** = action, device, procedure, that removes or reduces a vulnerability.

A threat is blocked by control of a vulnerability.

# 1.2 Threats

CIA:

1. Confidentiality: the ability of a system to ensure that an asset is viewed only by authorized parties.

2. Integrity: the ability of a system to ensure that an asset is only modified by authorized parties.

3. Availability: The ability of a system to ensure that an asset can be used by any authorized parties.

Harm can also be characterized by four acts: interception, interruption, modification and fabrication.

## Failures of Confidentiality:

* An unauthorized person, process or program accesses a data item.
* A person authorized to certain data accesses other data.
* An unauthorized person accesses an approximate data.
* An unauthorized person learns the existence of a piece of data.

the person is the subject, the data is the object, the kind of access is the access mode and the authorization of a policy.

## Integrity

Can refer to data being precise, accurate, unmodified, modified only in acceptable ways, by authorized people, consistent, meaningful and usable.

## Availability

The criteria for availability are as follows:

1. There is a timely response to a request
2. Resources are allocated fairly so that some requesters are not favoured over others.
3. Concurrency is controlled, simultaneous access, deadlock management and exclusive access are supported as required.
4. The service has fault tolerance, with workarounds that soft fail rather than crash and lose access to information or the information itself.
5. The service or system can be used easily.

## Types of Threats

Human threats can be benign, or malicious.

**Nonmalicious** threats include someone accidentally building a flaw into a program, or deleting data by clicking the wrong button.

**Malicious** threads is attacking a system, in order to cause harm and can be random or directed against a particular group, person, product or system.

## Advanced Persistent Threat

Come from large, well-financed, patient organizations and assailants. Often affiliated with governments, these attackers engage in well-planned, long compaigns.

## 1.3 Harm

Choosing the threats we try to mitigate is called **risk management**.

## Method, Opportunity, Motive

**Method** = the skills, knowledge, tools and other things which are required to perpetrate the act.

**Opportunity** = time and access to execute an attack.

**Motive** = the reason an attacker wants to attack.

Without all three, an attack will fail.

## 1.4 Vulnerability

**Attack surface** = system's full set of vulnerabilities, actual and potential.

## 1.5 Controls

The possibility for harm to occur is the **risk**. We can deal with harm by:

* Preventing it: blocking the attack or closing the vulnerability.
* Deterring it: making the attack harder but not impossible.
* Deflecting it: making another target more attractive, or this one less attractive.
* Mitigating it: making its impact less severe.
* Detecting it: either as it happens or some time after the fact.
* Recover from it: restore the system to a functional, CIA state.

**Physical controls** = stop or block an attack using tangible things, walls or fences, human guards, fire extinguishers.

**Procedural or Administrative controls** = laws, regulations, copyrights, patents, contracts, agreements.

**Technical controls** = passwords, network protocols, encryption, firewalls.
