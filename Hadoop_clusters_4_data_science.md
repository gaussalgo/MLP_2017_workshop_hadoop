# Basics of building a production Hadoop cluster

## Brief intro to Hadoop

Hadoop has been a fundamental technology that has enabled techniques such as Machine Learning to be widely adopted. Data analytics is most efficient when done where the data lies and not moving it around, while still being able to perform individual tasks in parallel. Tools within the Hadoop ecosystem have been production tested by some of the largest organizations in world on use cases requiring real-time stream processing, distributed machine learning or exploratory data science. We've passed the point where we have struggled to process large volumes of data and it would be good to remind ourselves what Hadoop is and how enterprises can easily adopt it.

...

## Challenges that enterprise companies face today when adopting data science

Data in enterprise is complex. The questions data scientists ask often require a very specific approach. Often they require to build advance models and methods to maintain a sustainable competitive advantage. It's important to understand the work of data scientists, where a major part of them solving complex issues is down to experimentation and innovation. Secondly data science teams are very diverse. Few companies will be able to find employees who have the whole skill package (statistics, machine learning, software engineering, mathematics, ...) and more realistically will create teams consisting of individuals skilled in one or two areas. These teams are most effective when they are not limited by technology or processes within the enterprise.

### too many software options

This is in fact good news. There is an extensive set of tools and frameworks out there to help data scientists solve the most complex problems. On the other hand implementing these individual solutions into enterprise environments has been challenging. Systems like Hadoop have enabled to parallel process and store massive amounts of data and the question is how can popular tools among data scientist fully utilize these capabilities.

### data science on a small scale

Data scientist use a wide range of tools and programming languages. The challenge is to build an architecture, which can manage many environment permutations, while keeping data secured and under control. This forces IT teams either to move data around to dedicated environments for data scientists or resources are limited, forcing teams to work on local desktop environments on limited data sets.  

### enterprise IT needs

Enterprise IT departments have a very important role in the adoption of these capabilities. IT is responsible for compliance with corporate directives like security and governance. It's hard enough to manage such complex environments through common interfaces such as SQL. It becomes much harder when every team, user, and project uses a different set of open source tools. Building a data science ready environment should consider

### moving work to production

Getting from a working model to production application has been difficult, even with the vast amount of tooling available. In the Hadoop world you need to constantly consider distribution in order to effectively utilize resources and data within the cluster. Different team will require different environments, where it needs to come into agreement with compliance and security. This has led to very inflexible setups, where a small change of code requires hours of operational work. These facts have lowered the success rate of moving data science solutions into production.

## Making the journey from concept to production easier

The following steps have been created based on our experience at Gauss Algorithmic, when engaging with enterprise customers who wish to build out advance analytic capabilities within their organization

1. Being clear about the problems you would like to solve
2. Data strategy and governance
3. Getting people onboard
4. Production first approach to architecture
5. Moving models to production

### Being clear about the problems you would like to solve

Being clear from a business perspective on what are the goals for adopting advance data analytics techniques and technology will help architects to create a better fit for purpose system at the right scale.

* architectures based business cases requiring real-time data processing can be fundamentally different from those requiring computation across large datasets
* understanding what type or workloads to expect help create a more specific design and avoid unnecessary/incorrect sizing

### Data strategy and governance

**Data strategy** is mainly about step 1 being official and transparent to the company. Here are some ideas to consider:
* Plan both short term and long term milestones.
* Make realistic short term goals and ambitious long term goals.
* Do not limit to solving issues in single departments.
* Monetization is more attractive then cost saving.

**Data governance** can be done at different stages within the lifecycle. The main thing we tend to focus on is to be clear about roles and ownerships.
* understand the current data landscape of the company
* identify data sources
* identify owners of the data sources

### Getting people on board

Team Composition

Function  | Roles  | Description  | Small Project  | Medium Project  | Large Project
--|---|---|---|---|--
Data Science  | Data Scientist  | A person or collection of people with developer, statistical and business domain expertise.  | 1  | 2  | 3
---  | Application Developer  | A person who develops new business applications and is a data steward for those applications.  | 0  | 1  | 3
---  | Power Analyst  | An analyst with programming skills that allow the creation of derived data products.  | 0  | 1  | 2
---  | Analyst  | A analyst who uses primarily SQL based analytic tools.  | 1  | 2  | 5
Data Engineering  | Data Engineer  | This role spans data management and analytics and is critical in the data discovery process. Has a domain understanding of both the data and the use cases and therefor is responsible for creating common profiles for elements to facilitate reusability.  | 0  | 1  | 2
---  | Data Stewards  | The person responsible for the data elements contained in a data source from an originating system. Is responsible for creating and logging data.  | 0  | 1  | 2
---  | Data Ingest (ETL)  | Responsible for developing the ingest and processing to onboard new data feeds and to apply simple schemas. This is a development role and is also considered a Jr. Data Engineer.  | 1  | 3  | 5
---  | Data Operations  | Responsible for the maintaining of Service Levels on end-to-end data pipelines. This is an operational role.  | 0  | 0  | 1
---  | Information Security  | Oversight and accountability for the installation and management of security systems across the entire organtization's network and enforcing compliance to data security, privacy and retention policies and processes.  | 0  | 0  | 1
Infrastructure Architecture and Operations  | Enterprise Architect  | Owns the ecosystem Architecture and how it integrates with the other applications in the data center. Continuously explores new technology and determines how it integrates / impacts the ecosystem.  | 0  | 1  | 3
---  | Hadoop Administrator  | Responsible for cluster SLA's  | 1  | 1  | 2
---  | Network Administrator  | Network support for the cluster  | 0  | 0  | 1
---  | Systems Administrator  | Level 1/2 support for the cluster  | 0  | 1  |  1
Total  | ---  | ---  | 4  | 14  | 31


## Architecture

### Basic points to consider when designing a modern Hadoop ecosystem

* batch vs. real-time
* existing ecosystem
* access patterns
  * end user needs
  * applications
  * ingest
* high availability
* hardware vs cloud
  * scale
  * storage needs
* security
* support

### Basic production setup

Here is an example of a basic production setup.

![](images/cluster_architecture.png)

Features:
* 2 Master nodes for HDFS Namenode and YARN ResourceManager HA
* 3 realtime nodes for fast ingestion and processing
* 8-20 worker nodes with storage (HDFS) and computation (Spark, Impala, YARN) features
* 3 utility nodes for Cloudera software (Manager, Navigator, Data Science Workbench), gateway access, Hive metastore and other applications
* Also this setup co-exists and utilizes existing infrastructure
  * Active Directory (LDAP, Kerberos)
  * Applications (internal, mobile)
  * Monitoring Tools


> One you go over 20 worker nodes its recommended to slightly change the master setup. See [documentation](https://www.cloudera.com/documentation/enterprise/latest/topics/cm_ig_host_allocations.html#concept_f43_j4y_dw)

### Brief description of tools and software

* HDFS
* YARN
* Spark
* Zookeeper
* Hive
* Impala
* Kafka
* Oozie
* Cloudera Manager
* HUE
* Redis
* Flume
* Jupyter notebooks
* Cloudera Data Science Workbench

## Further reading

Some great articles to help you with designing and building a Hadoop Cluster.

http://blog.cloudera.com/blog/2013/08/how-to-select-the-right-hardware-for-your-new-hadoop-cluster/
