---
title: JVM 参数设置
date: 2019-05-20 14:30:46
tags: [JAVA,JVM]
categories:
  - 编程
---

`JDK8-废弃永久代（PermGen）迎来元空间（Metaspace）`

`移除永久代是为融合HotSpot JVM与 JRockit VM而做出的努力，因为JRockit没有永久代，不需要配置永久代。`

JVM内存为两块：PermanentSapce和HeapSpace

PermanentSapce：存放代码的(字节码)

HeapSpace：堆

其中HeapSpace= {Old + NEW {= Eden , from, to } }


一般设置一下内存大小和回收策略就行了

---

<!--more-->

## 参数
-server：

一定要作为第一个参数，在多个 CPU 时性能佳，还有一种叫

-client: 

的模式，特点是启动速度比较快，但运行时性能和内存管理效率不高，通常用于客户端应用程序或开发调试，在 32 位环境下直接运行 Java 程序默认启用该模式。Server 模式的特点是启动速度比较慢，但运行时性能和内存管理效率很高，适用于生产环境，在具有 64 位能力的 JDK 环境下默认启用该模式，可以不配置该参数。

-Xms：

表示 Java 初始化堆的大小，-Xms 与-Xmx 设成一样的值，避免 JVM 反复重新申请内存，导致性能大起大落，默认值为物理内存的 1/64，默认（MinHeapFreeRatio参数可以调整）空余堆内存小于 40% 时，JVM 就会增大堆直到 -Xmx 的最大限制。

-Xmx：

表示最大 Java 堆大小，当应用程序需要的内存超出堆的最大值时虚拟机就会提示内存溢出，并且导致应用服务崩溃，因此一般建议堆的最大值设置为可用内存的最大值的80%。如何知道我的 JVM 能够使用最大值，使用 java -Xmx512M -version 命令来进行测试，然后逐渐的增大 512 的值,如果执行正常就表示指定的内存大小可用，否则会打印错误信息，默认值为物理内存的 1/4，默认（MinHeapFreeRatio参数可以调整）空余堆内存大于 70% 时，JVM 会减少堆直到-Xms 的最小限制。

-Xss：

表示每个 Java 线程堆栈大小，JDK 5.0 以后每个线程堆栈大小为 1M，以前每个线程堆栈大小为 256K。根据应用的线程所需内存大小进行调整，在相同物理内存下，减小这个值能生成更多的线程，但是操作系统对一个进程内的线程数还是有限制的，不能无限生成，经验值在 3000~5000 左右。一般小的应用， 如果栈不是很深， 应该是128k 够用的，大的应用建议使用 256k 或 512K，一般不易设置超过 1M，要不然容易出现out ofmemory。这个选项对性能影响比较大，需要严格的测试。

-XX:NewSize：设置新生代内存大小。

-XX:MaxNewSize：设置最大新生代新生代内存大小

~~-XX:PermSize：设置持久代内存大小~~JDK8 后被抛弃，使用-XX:MetaspaceSize替代，一般不需要调整

~~-XX:MaxPermSize：设置最大值持久代内存大小，永久代不属于堆内存，堆内存只包含新生代和老年代。~~JDK8 后被抛弃，使用-XX:MaxMetaspaceSize替代,一般不需要调整

**-XX:MaxPermSize=size**

Sets the maximum permanent generation space size (in bytes). This option was deprecated in JDK 8, and superseded by the -XX:MaxMetaspaceSize option.

**-XX:PermSize=size**

Sets the space (in bytes) allocated to the permanent generation that triggers a garbage collection if it is exceeded. This option was deprecated un JDK 8, and superseded by the -XX:MetaspaceSize option.

**-XX:MaxMetaspaceSize=size**

Sets the maximum amount of native memory that can be allocated for class metadata. By default, the size is not limited. The amount of metadata for an application depends on the application itself, other running applications, and the amount of memory available on the system.

The following example shows how to set the maximum class metadata size to 256 MB:

-XX:MaxMetaspaceSize=256m

**-XX:MetaspaceSize=size**

Sets the size of the allocated class metadata space that will trigger a garbage collection the first time it is exceeded. This threshold for a garbage collection is increased or decreased depending on the amount of metadata used. The default size depends on the platform.

因为默认的类的元数据分配只受本地内存大小的限制，也就是说本地内存剩余多少，理论上Metaspace就可以有多大

-XX:+AggressiveOpts：

作用如其名（aggressive），启用这个参数，则每当 JDK 版本升级时，你的 JVM 都会使用最新加入的优化技术（如果有的话）。

-XX:+DisableExplicitGC：

禁用System.gc() ,在 程序代码中不允许有显示的调用“System.gc()”。每次在到操作结束时手动调用 System.gc() 一下，付出的代价就是系统响应时间严重降低，就和关于 Xms，Xmx 里的解释的原理一样，这样去调用 GC 导致系统的 JVM 大起大落。

-Xmn：

新生代的内存空间大小，可以替代-XX:NewSize,-XX:MaxNewSize
对-XX:newSize、-XX:MaxnewSize两个参数同时进行配置（注意：JDK1.4之后才有该参数）。

-Duser.timezone=Asia/Shanghai：

设置用户所在时区。

-XX:NewRatio：

年轻代（包括 Eden 和两个 Survivor 区）与年老代的比值（除去持久代），-XX:NewRatio=4 表示年轻代与年老代所占比值为 1:4，年轻代占整个堆栈的 1/5，Xms=Xmx 并且设置了 Xmn 的情况下，该参数不需要进行设置。

-XX:SurvivorRatio：

Eden 区与 Survivor 区的大小比值，设置为 8，表示 2 个 Survivor 区（JVM 堆内存年轻代中默认有 2 个大小相等的 Survivor 区）与 1 个 Eden 区的比值为 2:8，即 1 个 Survivor 区占整个年轻代大小的 1/10。

-XX:+UseConcMarkSweepGC：

设置年老代为并发收集，即 CMS gc，这一特性只有 jdk1.5
后续版本才具有的功能，它使用的是 gc 估算触发和 heap 占用触发。我们知道频频繁的 GC 会造面 JVM
的大起大落从而影响到系统的效率，因此使用了 CMS GC 后可以在 GC 次数增多的情况下，每次 GC 的响应时间却很短，比如说使用了 CMS
GC 后经过 jprofiler 的观察，GC 被触发次数非常多，而每次 GC 耗时仅为几毫秒。

-XX:+UseParNewGC：

对新生代采用多线程并行回收，这样收得快，注意最新的 JVM 版本，当使用 -XX:+UseConcMarkSweepGC 时，-XX:UseParNewGC 会自动开启。因此，如果年轻代的并行 GC 不想开启，可以通过设置 -XX：-UseParNewGC 来关掉。



资料

[Configuring the Default JVM and Java Arguments官方文档](https://docs.oracle.com/cd/E22289_01/html/821-1274/configuring-the-default-jvm-and-java-arguments.html)

[JVM 参数介绍官方文档](https://docs.oracle.com/javase/8/docs/technotes/tools/unix/java.html)

[JVM中的-Xms -Xmx -XX:newSize -XX:MaxnewSize -Xmn -XX:PermSize -XX:MaxPermSize区别介绍](https://blog.csdn.net/tree_ifconfig/article/details/81222196)

[生产环境的tomcat调优和jvm调化](https://blog.csdn.net/ljj_9/article/details/79145324)

[JVM调优总结，比较详细](https://www.cnblogs.com/andy-zhou/p/5327288.html)

[java--jvm启动的参数](https://www.cnblogs.com/w-wfy/p/6415856.html)

[JVM垃圾回收机制与内存回收](https://www.cnblogs.com/sjxbg/p/9388615.html)
