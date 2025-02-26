package main

import (
	"fmt"
	"sync"
	"time"
)

// Interface definition
type Processor interface {
	Process() error
}

// Struct with embedded types
type TestStruct struct {
	sync.Mutex
	name string
	data map[string]interface{}
}

func (t *TestStruct) Process() error {
	// Goroutine and channel test
	ch := make(chan string, 1)
	go func() {
		defer close(ch)
		ch <- "测试数据"
	}()

	select {
	case result := <-ch:
		fmt.Printf("收到: %s\n", result)
	case <-time.After(time.Second):
		return fmt.Errorf("超时")
	}

	return nil
}
