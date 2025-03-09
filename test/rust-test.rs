use std::future::Future;
use async_trait::async_trait;

// Generic trait
trait GenericTrait<T> {
    fn get_data(&self) -> &T;
    fn process(&self, input: T) -> T;
}

#[derive(Debug)]
struct TestStruct<T> {
    name: String,
    value: i32,
    data: Vec<T>,
}

impl<T> TestStruct<T> {
    fn new(name: String, value: i32) -> Self {
        TestStruct {
            name,
            value,
            data: Vec::new(),
        }
    }

    async fn process_async<U>(&self, input: U) -> U {
        tokio::time::sleep(std::time::Duration::from_millis(100)).await;
        input
    }
}

impl<T> GenericTrait<T> for TestStruct<T>
where
    T: Clone,
{
    fn get_data(&self) -> &T {
        &self.data[0]
    }

    fn process(&self, input: T) -> T {
        input
    }
}
