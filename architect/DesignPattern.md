# 设计模式

必考要记：
- 创建：厂长抽着烟单手建造原型
  - 5 个：工厂 抽象工厂 单例 创建 原型 
- 结构：过桥享受代理人组装适配的外观
  - 8 个：过滤器 桥接 享元 代理 组合 装饰 适配 外观
- 行为：其余


- GOF 四人帮 Gang of Four 在 1994 年，由 Erich Gamma、Richard Helm、Ralph Johnson 和 John Vlissides 四人合著出版了一本名为 Design Patterns - Elements of Reusable Object-Oriented Software（中文译名：设计模式 - 可复用的面向对象软件元素） 的书，该书首次提到了软件开发中设计模式的概念。

- OCP 开闭原则     Open Close Principle 对扩展开放，对修改关闭
- LSP 里氏代换原则 Liskov Substitution Principle 子类替换任何位置的基类
- DIP 依赖倒转原则 Dependence Inversion Principle 针对接口编程，依赖抽象而不是具体
- ISP 接口隔离原则 Interface Segregation Principle 多个隔离的接口而不是单个
- DP  最少知道原则 Demeter Principle (迪米特法则) 实体之间尽量少发生相互作用
- CRP 合成复用原则 Composite Reuse Principle 使用合成/聚合而不是继承（装饰器模式）

# JDK中用到的设计模式总结

- 【创建型模式】  Creational Patterns 5 (厂长抽着烟单手建造原型)
  - 工厂模式    （Factory Pattern）`Charset#forName(String charsetName) DriverManager#getConnection`
  - 抽象工厂模式（Abstract Factory Pattern） `javax.xml.parsers.DocumentBuilderFactory#newInstance().newDocumentBuilder()`
  - 单例模式    （Singleton Pattern）`Runtime#getRuntime()`
  - 建造者模式  （Builder Pattern）`ProcessBuilder`
  - 原型模式    （Prototype Pattern）复制对象 `ArrayList#clone()`
- 【结构型模式】  Structural Patterns 8 （过桥享受代理人组装适配的外观）
  - 适配器模式  （Adapter Pattern）接口转换 `Arrays#asList()` 缺省适配器模式：提供空实现的适配器类
  - 桥接模式    （Bridge Pattern） `DriverManager#getConnection`
  - 过滤器模式  （Filter、Criteria Pattern） `FileFilter`
  - 组合模式    （Composite Pattern） 统一处理叶子与组合对象 `javax.swing.JComponent`
  - 装饰器模式  （Decorator Pattern）`BufferedInputStream` 运行时、任意多个、避免子类数量膨胀
  - 外观模式    （Facade Pattern）`java.net.URL 统一访问多种网络协议资源` 简化客户端调用、降低耦合度、隐藏实现细节
  - 享元模式    （Flyweight Pattern） `Integer#valueOf(int) -128 ~ 127`
  - 代理模式    （Proxy Pattern） `Proxy#newProxyInstance(ClassLoader,Class[],InvocationHandler)`
- 【行为型模式】  Behavioral Patterns 12 （这命的解需要叠中杯奶茶，观察状态蒸发到空，策马膜拜访问众神）
  - 责任链模式  （Chain of Responsibility Pattern） `javax.servlet.Filter#doFilter`
  - 命令模式    （Command Pattern） 将请求封装为对象 `Runnable`
  - 解释器模式  （Interpreter Pattern） `SimpleDateFormat`
  - 迭代器模式  （Iterator Pattern） `Iterator<T> hasNext(), next()`
  - 中介者模式  （Mediator Pattern） `java.awt.EventQueue`、控制器（Controller）充当模型（Model）与视图（View）的中介者
  - 备忘录模式  （Memento Pattern） `javax.swing.undo.UndoableEdit`
  - 观察者模式  （Observer Pattern） `java.util.Observer` `java.awt.Button#addActionListener`
  - 状态模式    （State Pattern） `java.lang.Thread.State 没有将每个状态的行为（方法）抽象到一个接口中`
  - 空对象模式  （Null Object Pattern）`Collections#emptyList()`
  - 策略模式    （Strategy Pattern）`Comparator`
  - 模板模式    （Template Pattern） `AbstractList`
  - 访问者模式  （Visitor Pattern） `FileVisitor`
- 【J2EE 设计模式】
  - MVC 模式        （MVC Pattern）
  - 业务代表模式    （Business Delegate Pattern）
  - 组合实体模式    （Composite Entity Pattern）
  - 数据访问对象模式（Data Access Object Pattern）
  - 前端控制器模式  （Front Controller Pattern）
  - 拦截过滤器模式  （Intercepting Filter Pattern）
  - 服务定位器模式  （Service Locator Pattern）
  - 传输对象模式    （Transfer Object Pattern）


# JDK中用到的设计模式详细

## 【创建型模式】 Creational Patterns

### 工厂模式（Factory Pattern）
```java
/**
@see java.util.Calendar#getInstance()
@see java.text.NumberFormat#getInstance() / getNumberInstance() / getCurrencyInstance()
@see java.nio.charset.Charset#forName(String charsetName)
@see java.sql.DriverManager#getConnection(String url)
*/
```
- 静态工厂
```java
/**
@see java.util.Collections#unmodifiableList / synchronizedCollection()
@see java.util.concurrent.Executors#newFixedThreadPool(int nThreads) / newCachedThreadPool()
@see java.lang.reflect.Array#newInstance
*/
```

### 抽象工厂模式（Abstract Factory Pattern）
```java
/**
@see javax.xml.parsers.DocumentBuilderFactory#newInstance().newDocumentBuilder()
@see javax.xml.transform.TransformerFactory#newInstance().newTransformer()
*/
```

### 单例模式（Singleton Pattern）
- 懒汉式、饿汉式、双检锁、静态内部类、枚举
- 双检锁 Double-Checked Locking 变量注意要加 volatile

- 饿汉式单例 Eager Initialization
```java
/**@see java.lang.Runtime#getRuntime()  */
```

- 懒汉式单例 Lazy Initialization
```java
/**
@see java.awt.Desktop#getDesktop() 
@see java.util.logging.LogManager#getLogManager()
*/
```

- 静态常量单例
```java
/**@see java.util.Collections#emptyList() */
```

### 建造者模式（Builder Pattern）
```java
/**
@see java.lang.StringBuilder 非严格意义上的 GOF 建造者模式
@see java.util.stream.Stream.Builder
@see java.time.format.DateTimeFormatterBuilder
@see java.net.http.HttpClient.Builder
@see java.util.Locale.Builder
@see javax.xml.parsers.DocumentBuilderFactory
@see java.lang.ProcessBuilder
*/
```

### 原型模式（Prototype Pattern）复制对象
```java
/** 实现 {@link java.lang.Cloneable} 并重写 Object.clone()
@see java.util.ArrayList#clone() 等集合类
@see java.util.Date#clone() 等日期时间类
@see java.lang.String 虽然实现了 Cloneable，但未公开 clone() 方法（字符串不可变性使其无需克隆）
@see java.util.Arrays 其数组拷贝方法（如 Arrays.copyOf()）本质是原型模式的变体
*/
```

## 【结构型模式】 Structural Patterns

### 适配器模式（Adapter Pattern）接口转换
```java
/**
@see java.io.InputStreamReader / OutputStreamWriter 将字节流适配为字符流，通过内部封装 InputStream/OutputStream 并实现 Reader/Writer 接口
@see java.util.Collections#list(java.util.Enumeration)
@see java.util.Arrays#asList()
*/
```
- 缺省适配器模式：提供空实现的适配器类，只需重写需要的方法而非所有接口方法，空对象模式（Null Object）的变体
```java
/** @see java.awt.event.MouseAdapter */
```

### 桥接模式（Bridge Pattern）
```java
/**
@see java.sql.DriverManager#getConnection
@see java.util.logging.Handler.setFormatter 被子类调用
*/
```
- 桥接模式强调抽象与实现的长期结构解耦
- 策略模式侧重算法的动态替换

### 过滤器模式（Filter、Criteria Pattern）
```java
/**
@see java.io.FileFilter 等，未严格遵循 GOF 的过滤器模式结构
*/
```

### 组合模式（Composite Pattern） 统一处理叶子与组合对象
```java
/**
@see javax.swing.JComponent 等
*/
```

### 装饰器模式（Decorator Pattern）
```java
/**
@see java.io.BufferedInputStream：添加缓冲功能
@see java.io.DataInputStream：添加基本类型读取（如 readInt()）
@see java.io.PushbackInputStream：支持回退字节
@see java.io.BufferedReader：添加缓冲和 readLine() 方法
@see java.io.LineNumberReader：添加行号计数
@see java.util.Collections#unmodifiableList：创建不可修改的集合视图
@see java.util.Collections#synchronizedList：创建线程安全的同步集合
@see java.util.Collections#checkedList：创建类型安全视图
*/
```
| **装饰器模式**         | **继承**               |
|------------------------|------------------------|
| 运行时动态扩展功能     | 编译时静态扩展         |
| 支持任意组合多个功能   | 单一继承，组合能力有限 |
| 避免类爆炸问题         | 易导致子类数量膨胀     |




### 外观模式（Facade Pattern）
```java
/**
@see java.net.URL 统一访问多种网络协议资源
@see javax.imageio.ImageIO
@see java.util.logging.Logger
*/
```
- 简化客户端调用
- 降低耦合度
- 隐藏实现细节

### 享元模式（Flyweight Pattern）
```java
/**
@see java.lang.Integer#valueOf(int) & Long & Byte & Short -128 ~ 127
@see java.lang.Character#valueOf(char) 0 ~ 127
@see java.lang.Boolean#valueOf(boolean)
@see java.lang.String 字符串常量池
@see java.lang.Enum 每个枚举常量在JVM中是单例对象，全局唯一
@see javax.sql.DataSource
@see java.util.concurrent.ConcurrentHashMap
*/
```

### 代理模式（Proxy Pattern）
- 解耦客户端与真实对象，常用于实现 AOP（日志、事务）、远程调用、延迟加载等场景。
- 对于无接口的类，可使用 CGLIB 等三方库实现代理
```java
/**
@see java.lang.reflect.InvocationHandler#invoke(java.lang.Object, java.lang.reflect.Method, java.lang.Object[])
@see java.lang.reflect.Proxy#newProxyInstance(java.lang.ClassLoader, java.lang.Class[], java.lang.reflect.InvocationHandler) 
@see java.rmi.server.RemoteObjectInvocationHandler（动态代理）
@see sun.reflect.annotation.AnnotationInvocationHandler（动态代理）
@see java.util.Collections#unmodifiableList：创建不可修改的集合视图（静态代理）
@see java.util.Collections#synchronizedList：创建线程安全的同步集合（静态代理）
*/
```
示例
```java
import java.lang.reflect.*;

interface UserService {
    void save();
}

class UserServiceImpl implements UserService {
    public void save() {
        System.out.println("保存用户数据");
    }
}

class LogHandler implements InvocationHandler {
    private Object target; // 被代理对象

    public LogHandler(Object target) {
        this.target = target;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println("[日志] 调用方法: " + method.getName());
        return method.invoke(target, args); // 调用真实对象的方法
    }
}

public class DynamicProxyDemo {
    public static void main(String[] args) {
        UserService realService = new UserServiceImpl();
        // 创建代理对象
        UserService proxy = (UserService) Proxy.newProxyInstance(
                realService.getClass().getClassLoader(),
                new Class[]{UserService.class}, // 代理接口
                new LogHandler(realService)     // 代理逻辑
        );

        proxy.save(); // 输出: [日志] 调用方法: save → 保存用户数据
    }
}
```


## 【行为型模式】 Behavioral Patterns
### 责任链模式（Chain of Responsibility Pattern）
```java
/**
@see java.util.logging.Logger#log(java.util.logging.LogRecord) parent
@see java.lang.ClassLoader#getResource parent 双亲委派模型
@see javax.servlet.Filter#doFilter 由各 Filter 决定是否传递至下一节点
 */
```
- 异常处理机制 try-catch：未处理的异常沿调用链传递，直至被捕获或终止程序
- AWT/Swing 事件处理：processEvent() 方法决定是否消费事件或继续传递

### 命令模式（Command Pattern） 将请求封装为对象
```java
/**
@see java.lang.Runnable
@see javax.swing.Action
@see java.util.TimerTask
*/
```

### 解释器模式（Interpreter Pattern）
```java
/**
@see java.util.regex.Pattern
@see java.text.Format SimpleDateFormat NumberFormat
@see java.text.Normalizer
*/
```

### 迭代器模式（Iterator Pattern）
```java
/**
@see java.util.Iterator<T> hasNext(), next()
*/
```

### 中介者模式（Mediator Pattern）
```java
/**
@see java.awt.EventQueue
*/
```
- Spring 事件驱动模型（ApplicationEventPublisher 与 ApplicationListener）
- Spring MVC 的 DispatcherServlet
- Spring MVC 的控制器（Controller）充当模型（Model）与视图（View）的中介者

### 备忘录模式（Memento Pattern）
```java
/**
@see javax.swing.undo.UndoableEdit Memento (备忘录) undo()/redo()
@see javax.swing.text.Document Originator (原发器)
@see javax.swing.undo.UndoManager Caretaker (管理者) addEdit() undo()/redo()
*/
```

### 观察者模式（Observer Pattern）
```java
/**
@see java.util.Observer 自 Java 9 起不再推荐使用。官方解释是其功能较为有限，且事件模型不够丰富，更推荐使用 java.beans 包中的功能或第三方库
@see java.beans.PropertyChangeSupport
@see java.beans.PropertyChangeListener
@see java.awt.Button#addActionListener
*/
```

### 状态模式（State Pattern）
```java
/**
@see java.util.Iterator 不同的迭代器实现封装了遍历不同数据结构（状态）的具体算法。对于使用者来说，他们只需要面对统一的Iterator接口，而遍历ArrayList和HashMap的行为完全不同
@see java.lang.Thread.State 没有将每个状态的行为（方法）抽象到一个接口中，但方法是否合法或会产生什么效果强烈依赖于其当前的状态
*/
```

### 空对象模式（Null Object Pattern）
```java
/**
@see java.util.Collections#emptyList(), emptySet(), emptyMap(), emptyIterator()
@see java.util.Optional#empty()
*/
```

### 策略模式（Strategy Pattern）
```java
/**
@see java.util.Comparator
@see java.util.concurrent.RejectedExecutionHandler
@see java.awt.LayoutManager
@see java.nio.file.FileVisitor
*/
```

### 模板模式（Template Pattern）
```java
/**
@see java.util.AbstractList
@see java.util.AbstractSet
@see java.util.AbstractMap
@see java.io.InputStream
@see java.io.OutputStream
@see java.io.Reader
@see java.io.Writer
@see java.util.concurrent.AbstractExecutorService
@see java.lang.Thread
 */
```

### 访问者模式（Visitor Pattern）
```java
/**
@see java.nio.file.FileVisitor 和 SimpleFileVisitor
*/
```

## 【J2EE 设计模式】

### MVC 模式（MVC Pattern）


### 业务代表模式（Business Delegate Pattern）


### 组合实体模式（Composite Entity Pattern）


### 数据访问对象模式（Data Access Object Pattern）


### 前端控制器模式（Front Controller Pattern）


### 拦截过滤器模式（Intercepting Filter Pattern）


### 服务定位器模式（Service Locator Pattern）


### 传输对象模式（Transfer Object Pattern）

