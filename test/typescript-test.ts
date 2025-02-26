// Decorators
function log(target: any) {
  console.log(target);
}

// Generic interface
interface GenericInterface<T> {
  data: T;
  process(input: T): T;
}

interface TestInterface {
  name: string;
  value: number;
}

type TestType = string | number;

@log
class TestClass implements TestInterface {
  name: string;
  value: number;
  private _data: TestType[];

  constructor(name: string, value: number) {
    this.name = name;
    this.value = value;
    this._data = [];
  }

  public addData(item: TestType): void {
    this._data.push(item);
  }

  // Generic method
  public async processData<T>(input: T): Promise<T> {
    return new Promise((resolve) => {
      setTimeout(() => resolve(input), 100);
    });
  }

  // Getter with type annotation
  get lastItem(): TestType | undefined {
    return this._data[this._data.length - 1];
  }
}
