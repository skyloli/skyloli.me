---
title: Gradle 打包jar的几种方式
date: 2019-5-1 22:53:25
categories:
  - [java, gradle]
---
## jar任务

打包成一个Jar

``` conf
jar {
    from {
        //添加依懒到打包文件
        //configurations.compile.collect { it.isDirectory() ? it : zipTree(it) }
        configurations.runtime.collect{zipTree(it)}
    }
    manifest {
        attributes 'Main-Class': appMainClass
    }
}
```

<!--more-->

打包成多个Jar

``` conf
jar {
    manifest {
        attributes 'Main-Class': appMainClass
    }
}

task clearJar(type: Delete) {
    delete 'build/libs/lib'
}

task copyJar(type: Copy) {
    from configurations.runtime
    into('build/libs/lib')
}

task release(type: Copy, dependsOn: [build, clearJar, copyJar])
```

执行命令gradle release或者./gradlew relesse，可在build/libs查看生成的jar包

两种方式都各有缺陷，打包成一个Jar当依懒比较多情况下Jar包会很大，其它工程要要单独引用某个Jar不方便；打包成多个Jar没有启动脚本，不熟悉Java的新手不懂得运行。

## application插件

``` conf
apply plugin: 'application'
mainClassName = appMainClass
```

执行命令`gradle build`或者`./gradlew build`，查看`build/distributions`会有两个压缩文件，压缩文件包含了两个文件夹，bin为启动脚本，lib则是软件jar包和依赖。还可以执行`./gradlew installDist`生成未压缩文件目录`build/install`。
这种方式最为简单，不需要添加复杂的脚本，打包成多个jar并生成启动脚本可一键运行

## 全部脚本参考

``` conf
def appMainClass = 'HelloWorldKt'

apply plugin: 'java'
apply plugin: 'kotlin'

apply plugin: 'maven'
archivesBaseName = 'app'
// 生成启动脚本打包
//apply plugin: 'application'
//mainClassName = appMainClass

sourceCompatibility = 1.8

repositories {
    mavenCentral()
}

dependencies {
    compile "org.jetbrains.kotlin:kotlin-stdlib-jre8:$kotlin_version"
    testCompile group: 'junit', name: 'junit', version: '4.12'
}

compileKotlin {
    kotlinOptions.jvmTarget = "1.8"
}
compileTestKotlin {
    kotlinOptions.jvmTarget = "1.8"
}

jar {
    configurations.runtime.each { println it.path }
    println "========="
    configurations.compile.each { println it.path }
    println "========="


    from {
        //添加依懒到打包文件
        //configurations.compile.collect { it.isDirectory() ? it : zipTree(it) }
        configurations.runtime.collect { zipTree(it) }
    }
    manifest {
        attributes 'Main-Class': appMainClass
    }
}

task clearJar(type: Delete) {
    delete 'build/libs/lib'
}

task copyJar(type: Copy) {
    from configurations.runtime
    into('build/libs/lib')
}

task release(type: Copy, dependsOn: [build, clearJar, copyJar])
```

## Gradle - 将依赖和资源文件打入jar包

用以下build.gradle打包出来的jar包，依赖是分离的：

``` conf
apply plugin: 'java'

dependencies {
    compile 'commons-codec:commons-codec:1.4'
    compile 'commons-logging:commons-logging:1.1.1'
    compile 'com.google.code.gson:gson:2.4'
    compile 'org.apache.httpcomponents:httpclient:4.3.6'
    compile 'com.strategicgains:RestExpress:0.11.2'
    compile 'com.fasterxml.jackson.core:jackson-databind:2.6.4'
    compile 'com.fasterxml.jackson.core:jackson-core:2.6.4'
    compile 'com.fasterxml.jackson.core:jackson-annotations:2.6.4'
    compile "ch.qos.logback:logback-core:1.1.3"
    compile "ch.qos.logback:logback-classic:1.1.3"
    compile 'net.kencochrane.raven:raven-logback:6.0.0'
    compile 'net.kencochrane.raven:raven:6.0.0'
    compile "org.slf4j:slf4j-api:1.7.13"
    compile 'com.rabbitmq:amqp-client:4.1.0'
    compile 'org.apache.commons:commons-lang3:3.4'
    compile 'commons-net:commons-net:3.4'
    compile 'org.zeromq:jeromq:0.3.5'
    compile fileTree(dir: 'libs', include: ['*.jar'])
    compile project(':tc-das')
    compile project(':result-compare')
}

jar {
    manifest {
        attributes(
                "Manifest-Version": 1.0,
                "Main-Class": "com.testbird.rio.Main",
                "Class-Path": configurations.compile.collect { "lib/${it.name}" }.join(' '))
    }
}
```

将build.gradle修改一下，就能将依赖和资源文件打入jar包了：

``` conf
apply plugin: 'java'

dependencies {
    compile 'commons-codec:commons-codec:1.4'
    compile 'commons-logging:commons-logging:1.1.1'
    compile 'com.google.code.gson:gson:2.4'
    compile 'org.apache.httpcomponents:httpclient:4.3.6'
    compile 'com.strategicgains:RestExpress:0.11.2'
    compile 'com.fasterxml.jackson.core:jackson-databind:2.6.4'
    compile 'com.fasterxml.jackson.core:jackson-core:2.6.4'
    compile 'com.fasterxml.jackson.core:jackson-annotations:2.6.4'
    compile "ch.qos.logback:logback-core:1.1.3"
    compile "ch.qos.logback:logback-classic:1.1.3"
    compile 'net.kencochrane.raven:raven-logback:6.0.0'
    compile 'net.kencochrane.raven:raven:6.0.0'
    compile "org.slf4j:slf4j-api:1.7.13"
    compile 'com.rabbitmq:amqp-client:4.1.0'
    compile 'org.apache.commons:commons-lang3:3.4'
    compile 'commons-net:commons-net:3.4'
    compile 'org.zeromq:jeromq:0.3.5'
    compile fileTree(dir: 'libs', include: ['*.jar'])
    compile project(':tc-das')
    compile project(':result-compare')
}

jar {
    manifest {
        attributes(
                "Manifest-Version": 1.0,
                "Main-Class": "com.testbird.rio.Main")
    }
    from { configurations.compile.collect { it.isDirectory() ? it : zipTree(it) } }
    into('assets') {
        from 'assets'
    }
}
```

---

[Gradle 打包jar的几种方式](https://www.jianshu.com/p/5bb1e87df15f)
[Gradle - 将依赖和资源文件打入jar包](https://www.cnblogs.com/jyx140521/p/6855210.html)
