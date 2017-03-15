
properties([
        buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10'))
])


def createPackage(String name, String type, String version, String description, String url, String inputPath, String configFiles,
                    String beforeInstall, String beforeRemove) {
    def outputPath = "${pwd()}/target/${name}-${version}.${type}"

    sh "/usr/local/bin/fpm --input-type dir " +
            "--output-type ${type} " +
            "--version ${version} " +
            "--name ${name} " +
            "--url ${url} " +
            "--description '${description}' " +
            "--license 'The Apache License, Version 2.0' " +
            "--vendor 'Confluent' " +
            "--architecture all " +
            "--maintainer jeremy@confluent.io " +
            "--config-files '${configFiles}' " +
            "--before-install '${beforeInstall}' " +
            "--before-remove '${beforeRemove}' " +
            "--package '${outputPath}' " +
            "'${inputPath}'"
    echo "Finished building ${outputPath}, stashing ${outputPath}"
    stash includes: "target/*.${type}", name: type
}


stage('build') {
    node {
        deleteDir()
        checkout scm

        sh "mkdir -p '${pwd()}/target/'"

        def version = '3.2.0'

        docker.image('jcustenborder/packaging-centos-7:24').inside {
            createPackage('schema-registry-server', 'rpm', version, 'Confluent Schema Registry', 'http://www.confluent.io',
                'schema-registry/el6', '/etc/sysconfig', 'schema-registry/el6/scripts/before-install', 'schema-registry/el6/scripts/before-remove')
        }
    }
}
