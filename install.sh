#!/bin/bash 

###################################################################
#Script Name	:Install istio GKE                                                                                              
#Description	:                                                                                 
#Args           	:                                                                                           
#Author       	:Matos Evandro Matos                                                
#Email         	:evandromatos.si.ti@gmail.com                                           
###################################################################

set -x

## Version kubernetes 1.15.12-gke.20

###install istio (1.6.8)
function download_Istio(){
    curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.6.8 sh -
    sleep 10
    cd istio-1.6.8
    export PATH=$PWD/bin:$PATH

}

##### Install without egress
function install_istio_without_egress(){
    istioctl install --set profile=default

}

##### Install with egress
function install_istio_with_egress(){
    istioctl install --set profile=default \
    --set components.egressGateways[0].enabled=true \
    --set components.egressGateways[0].name=istio-egressgateway

}

## Istio injection namespace default
function istio_injection_namespaces(){
    kubectl label namespace default istio-injection=enabled

}

### Istio analyze 
function istio_analyze(){
    istioctl analyze

}


## install jaeger
function install_jaeger(){
    kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/jaeger.yaml
    ##istioctl dashboard jaeger
}

###install prometheus
function install_prometheus(){
    kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/prometheus.yaml
    ##istioctl dashboard prometheus
}

####Install grafana
function install_grafana(){
    kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/grafana.yaml
    ##istioctl dashboard grafana
}

###Install Kiali
function install_kiali(){
    kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/kiali.yaml
    ##istioctl dashboard kiali
}


## call Function 

download_Istio
install_istio_without_egress
#install_istio_with_egress
istio_injection_namespaces
istio_analyze
install_jaeger
install_prometheus
install_grafana
install_kiali
