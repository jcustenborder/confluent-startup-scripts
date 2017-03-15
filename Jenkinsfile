
properties([
        buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10'))
])


def createPackage(String name, String outputFolder, String type, String version, String description, String url, String inputPath, String configFiles,
                    String beforeInstall, String beforeRemove) {
    def outputPath = "${outputFolder}/${name}-${version}.${type}"

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

        def outputPath = "${pwd()}/target/"

        sh "mkdir -p '${outputPath}'"

        def version = '3.2.0'

        dir('schema-registry/el6') {
            docker.image('jcustenborder/packaging-centos-7:24').inside {
                createPackage('schema-registry-server', outputPath, 'rpm', version, 'Confluent Schema Registry', 'http://www.confluent.io',
                    pwd(), 'etc/sysconfig', 'scripts/before-install', 'scripts/before-remove')
            }
        }
    }
}
