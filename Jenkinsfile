
properties([
        buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10'))
])

stage('build') {
    node {
        deleteDir()
        checkout scm

        docker.image('jcustenborder/packaging-centos-7:24').inside {
            sh "make clean all"
            archiveArtifacts 'target/el6/*.rpm'
            archiveArtifacts 'target/el7/*.rpm'
        }
    }
}
