package main

import (
	"csi-plugins/pkg/jvm"
	"flag"
	"k8s.io/klog"
)

var (
	endpoint string
	nodeID   string
)

func main() {
	flag.StringVar(&endpoint, "endpoint", "", "CSI Endpoint")
	flag.StringVar(&nodeID, "nodeid", "", "node id")

	klog.InitFlags(nil)
	flag.Parse()

	d := jvm.NewDriver(nodeID, endpoint)
	d.Run()
}
