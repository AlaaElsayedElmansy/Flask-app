pipeline {
  agent { label "slave"}
  stages {
    stage('build') {
      steps {
        script {
       
            withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'username', passwordVariable: 'password')]) {
              sh """
        
                  docker login -u ${username} -p ${password}
                  docker build -t alaaelmansy/hello_app:${BUILD_NUMBER} .
                  docker push alaaelmansy/hello_app:${BUILD_NUMBER}
                  echo ${BUILD_NUMBER} > ../app-number.txt
              """
          }
        } 
      }
    }
    stage('deploy') {
    
      steps {
        script {

            withCredentials([file(credentialsId: 'service-account', variable: 'key')]) {
              sh """
                  gcloud auth activate-service-account manage-sa@alaa-376816.iam.gserviceaccount.com --key-file ${key}
        
                """
            }
        


            withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
              sh """
                  export BUILD_NUMBER=\$(cat ../app-number.txt)
                  mv Deployment/deploy.yaml Deployment/deploy.yaml.tmp
                  cat Deployment/deploy.yaml.tmp | envsubst > Deployment/deploy.yaml
                  rm -f Deployment/deploy.yaml.tmp
                  kubectl apply -f Deployment --kubeconfig=${KUBECONFIG}
                """
            }
        }
      }
    }
  }
}
