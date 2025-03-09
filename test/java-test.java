import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

// Generic interface
interface GenericInterface<T> {
    T getData();
    T process(T input);
}

@FunctionalInterface
interface TestInterface {
    void execute();
}

class TestClass implements GenericInterface<String> {
    private String name;
    private int value;
    private List<Object> data;

    public TestClass(String name, int value) {
        this.name = name;
        this.value = value;
        this.data = new ArrayList<>();
    }

    @Override
    public String getData() {
        return name;
    }

    @Override
    public String process(String input) {
        return input.toUpperCase();
    }

    public <T> CompletableFuture<T> processAsync(T input) {
        return CompletableFuture.supplyAsync(() -> input);
    }
}
