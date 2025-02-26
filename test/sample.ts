// 注释样式测试
import { Component } from '@angular/core';

/**
 * 多行注释测试
 */
@Component({
  selector: 'app-root',
  template: `<div>测试模板字符串</div>`,
})
export class TestComponent {
  private testString: string = '测试字符串';
  public testNumber: number = 42;

  constructor() {
    console.log('构造函数测试');
  }
}
