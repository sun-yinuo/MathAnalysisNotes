// 修改这里,就能更新封面信息
#let book-title = "MathAnalysisNotes"
#let book-subtitle = "函数与基本语言"
#let author-name = "Martin"
#let edition = "version 0.1"

#set document(title: book-title, author: author-name)
#set page(paper: "a4", margin: 2.5cm, numbering: none)
#set text(
  lang: "zh",
  region: "cn",
  font: (
    "New Computer Modern", // 1. 英文与数字优先用经典学术衬线体（自带,无需安装）
    "Songti SC",           // 2. macOS 系统自带：宋体-简（华文宋体）
    "STSong",              // 3. macOS / Office 常见：华文宋体
    "Source Han Serif SC", // 4. 思源宋体
    "Noto Serif CJK SC",   // 5. Linux / Google 同源：思源宋体
    "SimSun",              // 6. Windows 系统自带：中易宋体
  ),
  size: 11pt
)
#set heading(numbering: "1.1")

// 封面
#v(4cm)
#align(center)[
  #text(size: 30pt, weight: "bold")[#book-title]

  #v(0.8cm)
  #text(size: 18pt)[#book-subtitle]

  #v(4cm)
  #text(size: 13pt)[#author-name]

  #v(0.5cm)
  #edition
]
#pagebreak()

// 自动目录：显示“篇”和“章”两级
#outline(title: [目录], depth: 3)
#pagebreak()

// 正文从第 1 页开始编号
#set page(numbering: "1", number-align: center)
#counter(page).update(1)


// 放在 shared/template.typ 中,替换掉原来的 hl 定义：
#let hl(color: rgb("#fef08a"), body) = {
  // 让高亮块内部的数学公式也自动加上同色背景盒
  show math.equation: it => box(
    fill: color,
    outset: (y: 2.5pt), // 上下稍微外扩一点,和两边汉字的高亮高度完美对齐
    it
  )
  highlight(fill: color, body)
}

// 放在 shared/template.typ 中,替换掉原来的 hl 定义：
#let hlo(color: rgb("#fab27e"), body) = {
  show math.equation: it => box(
    fill: color,
    outset: (y: 1.5pt), // 微调到与中文 highlight 齐平
    it
  )
  highlight(
    fill: color,
    top-edge: "ascender",
    bottom-edge: "descender",
    body
  )
}

// 放在 shared/template.typ 中,替换掉原来的 hl 定义：
#let hlb(color: rgb("#32c3f8b8"), body) = {
  // 让高亮块内部的数学公式也自动加上同色背景盒
  show math.equation: it => box(
    fill: color,
    outset: (y: 2.5pt), // 上下稍微外扩一点,和两边汉字的高亮高度完美对齐
    it
  )
  highlight(fill: color, body)
}

// 通用方框宏：默认白底黑框、带微圆角和舒适内边距
#let mybox(bg: white, border: black, body) = block(
  fill: bg,
  stroke: 0.8pt + border,
  radius: 4pt,
  inset: 12pt,
  width: 100%,
  body
)

#let bluebar(
  bg: rgb("#f0f9ff"),
  stroke: (left: 3.5pt + rgb("#38bdf8")),
  body
) = block(
  width: 100%,
  fill: bg,
  stroke: stroke,
  inset: (left: 12pt, right: 10pt, y: 10pt),
  radius: (right: 4pt),
  body
)



= 实数、集合与区间
== 实数与常用数集 
#h(2em) 本节沿用高中阶段的实数概念,整理其分类和基本性质,不展开实数系统的构造.
=== 实数、有理数与无理数 <sec:111>
#h(2em) #strong[本册的所有研究都建立在#hl[实数(real number)]之上的,所以我们不可避免的要引入实数的概念.]\
#h(2em) 实数分为#strong[有理数(rational number)]和#strong[无理数(irrational number)]两个部分,有理数是可以被表示为两个整数比的数;\

#bluebar[
#h(2em) 即,若一个数$r$满足
$ r=p/q #h(1em) (p,q"均为整数",q!=0) $
#h(2em) 那么我们就称$r$是有理数\
]

#h(2em) 反之,无法写成以上形式的实数就是无理数,#hl[有理数和无理数统称为实数],$3/2,1,pi,e,-e$都是一些常见的实数.
=== 实数的运算与大小关系
#bluebar( stroke: (left: 3.5pt + rgb("#f2f838")) )[

#h(2em) 公理: 对于两个实数,对其进行和、积运算的结果依然是实数,此条规则是在实数公理系统中有定义的,不必证明.\
#h(2em) 性质1: $a<b => a+c<b+c$\
#h(2em) 性质2: $a<b,c>0 => a c < b c$\
#h(2em) 性质3: $a<b,c<0 => a c > b c$\

]

#h(2em) 也就是两边加同一个数,大小关系不变;乘同一个正数,不等号方向不变;乘同一个负数,不等号方向反转;在证明以上三条性质之前,我们需要引入"$<$".\

#bluebar[
#h(2em) #strong[基本事实]
$ a<b <=> b-a>0(b-a in RR^+) $
]
\

#mybox[
#h(2em) 下面对#hl[性质1(加法保序性)]:$a<b => a+c<b+c$进行证明:\
#h(2em) #hlb[ #strong[证明]]\
#h(2em) 由$a<b$的定义可知:
$ b-a in RR^+ $
#h(2em) 由实数上的加法结合律和逆元性质可知:
$ (b+c)-(a+c)=b+c-a-c=b-a in RR^+ $
#h(2em) 由大小关系与差的正负之间的联系,得到:
$ a+c<b+c $
]

#mybox[
#h(2em) 下面对#hl[性质2(正数乘法保序性)]:$a<b,c>0 => a c < b c$进行证明:\
#h(2em) #hlb[ #strong[证明]]\
#h(2em) 由已知条件可知:
$ b-a in RR^+ ,c in RR^+ $
#h(2em) 根据正数乘法封闭性公理,两个正数的乘积仍为正数:
$ (b-a) c in RR^+ $
#h(2em) 由乘法分配律展开得:
$ b c - a c in RR^+ $
#h(2em) 由大小关系与差的正负之间的联系,得到:
$ a c < b c $
]

#mybox[
#h(2em) 下面对#hl[性质3(负数乘法反序性)]:$a<b,c<0 => a c > b c$进行证明:\
#h(2em) #hlb[ #strong[证明]]\
#h(2em) 由已知条件可知:
$ -c in RR^+,b-a in RR^+ $
#h(2em) 根据正数乘法封闭性公理,两者相乘为正数:
$ (b-a) (-c) in RR^+ $
#h(2em) 利用$(-1) (-1)=1$与分配律,化简得到:
$ (b-a) (-c)=a c - b c in RR^+ $
#h(2em) 由大小关系与差的正负之间的联系,得到:
$ a c>b c $
]
=== 常用数集
#align(center)[
  #table(
    columns: (1.2fr, 1.5fr, 2.5fr),
    stroke: none,          // 先清空所有默认网格线
    inset: (x: 10pt, y: 8pt),
    align: (center, left, left),

    // 1. 顶部粗线
    table.hline(stroke: 1.5pt + black),
    table.header(          // 使用 table.header 可以在跨页时自动重复表头！
      [*集合符号*], [*名称*], [*特征/例子*]
    ),
    // 2. 表头下方细线
    table.hline(stroke: 0.7pt + black),

    [$NN$], [自然数集\ Natural Number Set], [${0,1,2,3...}$],
    [$ZZ$], [整数集\ Zahlen(德语)], [${...-2,-1,0,1,2...}$],
    [$QQ$], [有理数集\ Quotient], [见上文定义(@sec:111)],
    [$RR$], [实数集\ Real Number Set], [见上文定义(@sec:111)],

    // 3. 底部粗线
    table.hline(stroke: 1.5pt + black),
  )
]

== 集合的运算
#h(2em) 注意:本章固定全集为$U$,并设$A,B,C subset.eq U$,所有补集均相对于$U$而言.
=== 集合运算的定义
#h(2em) 下面定义四种常见的集合运算
#bluebar[
#h(2em) #strong[定义]
#align(center)[
  #table(
    columns: (0.8fr, 1.8fr, 2fr),
    stroke: none,          // 先清空所有默认网格线
    inset: (x: 12pt, y: 8pt),
    align: (center, left, left),

    // 1. 顶部粗线
    table.hline(stroke: 1.5pt + black),
    table.header(          // 使用 table.header 可以在跨页时自动重复表头！
      [*运算*], [*定义*], [*说明*]
    ),
    // 2. 表头下方细线
    table.hline(stroke: 0.7pt + black),

    [$A inter B$], [$A inter B:={x | x in A and x in B}$], [$"取交集"$],
    [$A union B$], [$A union B := {x | x in A or x in B}$], [$"取并集"$],
    [$overline(A)$], [$overline(A) := {x in U | x in.not A} = U without A$], [$"取补集"$],
    [$A without B$], [$A without B := {x | x in A and x in.not B}$], [$"取差集"$\ $"属于"A"但不属于"B"的元素组成的集合"$],
    // 3. 底部粗线
    table.hline(stroke: 1.5pt + black),
  )
]
]


// 封装 4 种集合运算的 Venn 图绘制函数
#import "@preview/cetz:0.3.4"
// 封装 4 种集合运算的 Venn 图绘制函数（像素级对齐修正版）
#let draw-venn(mode, title) = cetz.canvas(length: 0.78cm, {
  import cetz.draw: *
  let hi-fill = rgb("#bfdbfe")       // 运算结果高亮填充色（清爽天空蓝）
  let border-col = rgb("#1e40af")    // 集合圆圈深蓝描边
  let u-border = gray.darken(30%)    // 全集 U 外框颜色

  let d = 0.65                       // 左右圆心距原点的半距
  let r = 1.1                        // 圆半径

  // 1. 绘制全集 U 底框
  rect(
    (-2.7, -1.65), (2.7, 1.65),
    fill: if mode == "comp" { hi-fill } else { white },
    stroke: 0.9pt + u-border,
    radius: 3pt
  )
  content((2.35, 1.3), text(size: 8.5pt, fill: u-border)[$U$])

  // 2. 根据不同运算模式绘制蓝色高亮区域
  if mode == "union" {
    circle((-d, 0), radius: r, fill: hi-fill, stroke: none)
    circle((d, 0), radius: r, fill: hi-fill, stroke: none)
  } else if mode == "inter" {
    // 精确计算两圆交点角度 theta = arccos(d / r) 与纵坐标 y0
    let theta = calc.acos(d / r)
    let y0 = calc.sqrt(r * r - d * d)
    // 从上交点 (0, y0) 出发，沿左圆右弧画到下交点 (0, -y0)，再沿右圆左弧闭合回上交点
    merge-path(fill: hi-fill, stroke: none, {
      arc((0, y0), start: theta, stop: -theta, radius: r)
      arc((0, -y0), start: 180deg + theta, stop: 180deg - theta, radius: r)
    })
  } else if mode == "diff" {
    circle((-d, 0), radius: r, fill: hi-fill, stroke: none)
    circle((d, 0), radius: r, fill: white, stroke: none)
  } else if mode == "comp" {
    circle((0, 0), radius: 1.15, fill: white, stroke: none)
  }

  // 3. 在最上层统一绘制清晰的集合边界圆与字母标签
  if mode == "comp" {
    circle((0, 0), radius: 1.15, fill: none, stroke: 1.3pt + border-col)
    content((0, 0), text(size: 9.5pt)[$A$])
    content((-1.85, -1.05), text(size: 9.5pt, fill: border-col)[$overline(A)$])
  } else {
    circle((-d, 0), radius: r, fill: none, stroke: 1.2pt + border-col)
    circle((d, 0), radius: r, fill: none, stroke: 1.2pt + border-col)
    content((-1.15, 0), text(size: 9.5pt)[$A$])
    content((1.15, 0), text(size: 9.5pt)[$B$])
  }

  // 4. 底部图题标注
  content((0, -2.15), text(size: 9.5pt, fill: black)[#title])
})
// ==================== 4 种集合运算 Venn 图 2×2 矩阵排版 ====================
#align(center)[
  #block(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 0.6pt + rgb("#cbd5e1"),
    radius: 6pt,
    inset: (x: 10pt, y: 14pt),
    breakable: false,
  )[
    #grid(
      columns: (1fr, 1fr),
      row-gutter: 16pt,
      column-gutter: 12pt,

      draw-venn("inter", [1. 交集 $A inter B$（公共部分）]),
      draw-venn("union", [2. 并集 $A union B$（全部合并）]),
      draw-venn("comp",  [3. 补集 $overline(A) = U without A$（全集剩余部分）]),
      draw-venn("diff",  [4. 差集 $A without B = A inter overline(B)$（属于 $A$ 但不属于 $B$）]),
    )
  ]
]

=== 集合运算的性质
#h(2em) 对于集合的运算,有以下性质
#bluebar( stroke: (left: 3.5pt + rgb("#f2f838")) )[

#h(2em) 1:交换律与结合律\
#h(4em) $A inter B = B inter A$\
#h(4em) $A union B = B union A$\
#h(4em) $(A inter B) inter C  = A inter (B inter C)$\
#h(4em) $(A union B) union C  = A union (B union C)$\

#h(2em) 2:分配律与吸收律\
#h(4em) $A inter (B union C) = (A inter B) union (A inter C)$\
#h(4em) $A union (B inter C) = (A union B) inter (A union C)$\
#h(4em) $A inter(A union B)=A$\
#h(4em) $A union(A inter B)=A$\

#h(2em) 3:德摩根律\
#h(4em) $overline(A union B)=overline(A) inter overline(B)$\
#h(4em) $overline(A inter B)=overline(A) union overline(B)$\

#h(2em) 4:与包含关系、差集的联系\
#h(4em) $A subset.eq B <=> A inter B = A <=> A union B =B$\
#h(4em) $A without B = A inter overline(B)$

#h(2em) 5:互补律\
#h(4em) $A inter overline(A) = emptyset$\
#h(4em) $A union overline(A) = U$

#h(2em) 6:幂等律\
#h(4em) $A inter A = A$\
#h(4em) $A union A = A$

#h(2em) 7:双重补集律\
#h(4em) $overline(overline(A))=A$
]
#h(2em) 注意到,以上7条或者更多类似于这样的集合性质都不是公理,需要被严格证明,这就牵扯到一种重要的证明方法,#hl[回归本质,即:定义],如下是对于德摩根律的两个证明：
#mybox[
#h(2em) 下面对#hl[德摩根律1]:$overline(A union B)=overline(A) inter overline(B)$进行证明:\
#h(2em) #hlb[ #strong[证明]]\
$
"任取"x in U\
x in overline(A union B)
  &<=> x in.not (A union B) \
  &<=> x in.not A and x in.not B \
  &<=> x in overline(A) and x in overline(B) \
  &<=> x in overline(A) inter overline(B)
$
#h(2em) 由于$x in U$是任意的,两边集合具有完全相同的元素,因此两集合相等,得到:
$ overline(A union B)=overline(A) inter overline(B) $
]
#mybox[
#h(2em) 下面对#hl[德摩根律2]:$overline(A inter B)=overline(A) union overline(B)$进行证明:\
#h(2em) #hlb[ #strong[证明]]\
$
"任取"x in U\
x in overline(A inter B)
  &<=> x in.not (A inter B) \
  &<=> x in.not A or x in.not B \
  &<=> x in overline(A) or x in overline(B) \
  &<=> x in overline(A) union overline(B)
$
#h(2em) 由于$x in U$是任意的,两边集合具有完全相同的元素,因此两集合相等,得到:
$ overline(A inter B)=overline(A) union overline(B) $
]

#h(2em) 其他若干种定律也可以通过类似的方法进行证明,这里不再赘述,留给读者自行证明.\
#h(2em) 面对集合问题我们常常可以使用Venn图来表示集合之间的逻辑关系,并使用数形结合的思想解决问题,如下是对于德摩根律的两个图形证明：

#import "@preview/cetz:0.3.4"

// 封装德摩根律分步视觉证明的子图函数
#let dm-panel(mode, caption) = cetz.canvas(length: 0.65cm, {
  import cetz.draw: *
  let d = 0.6
  let r = 1.0
  let border-col = rgb("#1e3a8a")
  let u-col = gray.darken(30%)

  // 配色方案：经典亮蓝 vs 双色半透明叠加
  let hi-blue = rgb("#93c5fd")
  let trans-a = rgb(59, 130, 246, 40%)   // 半透明蓝（代表 Ā）
  let trans-b = rgb(250, 204, 21, 50%)   // 半透明黄（代表 B̄，与蓝叠加自动变绿！）

  // ================= 1. 底层背景与集合区域涂色 =================
  if mode == "law1-lhs" {
    // 定律1 左式：overline(A ∪ B) -> 全集涂蓝，把 A ∪ B 挖白
    rect((-2.3, -1.5), (2.3, 1.5), fill: hi-blue, stroke: none, radius: 3pt)
    circle((-d, 0), radius: r, fill: white, stroke: none)
    circle((d, 0), radius: r, fill: white, stroke: none)
  } else if mode == "law1-rhs" {
    // 定律1 右式：Ā ∩ B̄ -> 全集外部为蓝+黄叠加绿，A内仅剩黄，B内仅剩蓝，A∩B为白
    rect((-2.3, -1.5), (2.3, 1.5), fill: rgb("#86efac"), stroke: none, radius: 3pt)
    circle((-d, 0), radius: r, fill: rgb("#fef08a"), stroke: none)
    circle((d, 0), radius: r, fill: rgb("#bfdbfe"), stroke: none)
    let theta = calc.acos(d / r)
    let y0 = calc.sqrt(r * r - d * d)
    merge-path(fill: white, stroke: none, {
      arc((0, y0), start: theta, stop: -theta, radius: r)
      arc((0, -y0), start: 180deg + theta, stop: 180deg - theta, radius: r)
    })
  } else if mode == "law2-lhs" {
    // 定律2 左式：overline(A ∩ B) -> 全集涂蓝，仅把中间的交集纺锤形 A ∩ B 挖白
    rect((-2.3, -1.5), (2.3, 1.5), fill: hi-blue, stroke: none, radius: 3pt)
    let theta = calc.acos(d / r)
    let y0 = calc.sqrt(r * r - d * d)
    merge-path(fill: white, stroke: none, {
      arc((0, y0), start: theta, stop: -theta, radius: r)
      arc((0, -y0), start: 180deg + theta, stop: 180deg - theta, radius: r)
    })
  } else if mode == "law2-rhs" {
    // 定律2 右式：Ā ∪ B̄ -> 只要被蓝(Ā)或黄(B̄)任意一个覆盖就算并集，唯独中间 A∩B 未被覆盖留白
    rect((-2.3, -1.5), (2.3, 1.5), fill: rgb("#86efac"), stroke: none, radius: 3pt)
    circle((-d, 0), radius: r, fill: trans-b, stroke: none)
    circle((d, 0), radius: r, fill: trans-a, stroke: none)
    let theta = calc.acos(d / r)
    let y0 = calc.sqrt(r * r - d * d)
    merge-path(fill: white, stroke: none, {
      arc((0, y0), start: theta, stop: -theta, radius: r)
      arc((0, -y0), start: 180deg + theta, stop: 180deg - theta, radius: r)
    })
  }

  // ================= 2. 顶层统一描边与文字标签 =================
  rect((-2.3, -1.5), (2.3, 1.5), fill: none, stroke: 0.9pt + u-col, radius: 3pt)
  content((1.95, 1.15), text(size: 8pt, fill: u-col)[$U$])
  circle((-d, 0), radius: r, fill: none, stroke: 1.1pt + border-col)
  circle((d, 0), radius: r, fill: none, stroke: 1.1pt + border-col)
  content((-1.05, 0), text(size: 8.5pt)[$A$])
  content((1.05, 0), text(size: 8.5pt)[$B$])

  // 3. 子图底部说明
  content((0, -2.0), text(size: 8.5pt)[#caption])
})

// ==================== 德摩根律几何直观证明对照框 ====================
#align(center)[
  #block(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 0.6pt + rgb("#cbd5e1"),
    radius: 6pt,
    inset: (x: 10pt, y: 12pt),
    breakable: false,
  )[
    #text(weight: "bold", size: 10pt, fill: rgb("#1e3a8a"))[德摩根律（De Morgan's Laws）的 Venn 图直观验证]
    #v(6pt)
    #grid(
      columns: (1fr, auto, 1fr),
      align: horizon + center,
      row-gutter: 14pt,
      column-gutter: 6pt,

      // 第一行：德摩根律 1
      dm-panel("law1-lhs", [左式：$overline(A union B)$（并集之外，蓝色区）]),
      text(size: 14pt, fill: rgb("#2563eb"))[$<==>$],
      dm-panel("law1-rhs", [右式：$overline(A) inter overline(B)$（黄 $overline(A)$ 与蓝 $overline(B)$ 重叠的*绿色公共区*）]),

      // 第二行：德摩根律 2
      dm-panel("law2-lhs", [左式：$overline(A inter B)$（交集之外，蓝色区）]),
      text(size: 14pt, fill: rgb("#2563eb"))[$<==>$],
      dm-panel("law2-rhs", [右式：$overline(A) union overline(B)$（除中心白区外，*所有有色区域之并*）]),
    )
  ]
]

#h(2em) TODO 例题
== 区间与邻域
#h(2em)以下默认变量 $x$ 取实数，端点 $a, b in bb(R)$,对具有两个有限端点的区间，约定 $a < b$。\
#h(2em)下面定义以下区间记号
#bluebar[
#h(2em) #strong[定义]
#align(center)[
  #table(
    columns: (1fr, 1.8fr, 2fr),
    stroke: none,          // 先清空所有默认网格线
    inset: (x: 12pt, y: 8pt),
    align: (center, left, left),

    // 1. 顶部粗线
    table.hline(stroke: 1.5pt + black),
    table.header(          // 使用 table.header 可以在跨页时自动重复表头！
      [*记号*], [*定义*], [*说明*]
    ),
    // 2. 表头下方细线
    table.hline(stroke: 0.7pt + black),

    [$(a,b)$], [${x | a<x<b}$], [开区间,有限区间],
    [$[a,b]$], [${x | a<=x<=b}$], [闭区间,有限区间],
    [$[a,b)$\ $(a,b]$], [${x | a<=x<b}$\ ${x | a<x<=b}$], [半开半闭区间,有限区间\ 半开半闭区间,有限区间],
    [$(-infinity,a]$], [${x | x<=a}$], [无限区间],
    [$(-infinity,a)$], [${x | x<a}$], [无限区间],
    [$(a,+infinity)$], [${x | x>a}$], [无限区间],
    [$[a,+infinity)$], [${x | x>=a}$], [无限区间],
    [$(-infinity,+infinity)$], [$RR$], [无限区间,等价于实数集$RR$],
    // 3. 底部粗线
    table.hline(stroke: 1.5pt + black),
  )
]
#h(2em) #hl[注意:符号$+infinity$,$-infinity$不表示实数,而表示区间向相应方向无限延伸,因此,无穷的一端总使用圆括号.]
]
#h(2em) 以上的有限区间与无限区间统称为区间,区间是数轴上连续区域的最简表达形式.通过开区间、闭区间、半开半闭区间,我们可以严谨、简洁地描述变量的取值范围;由此可见,#hl[区间的基本特征是:若两个实数属于该区间,则它们之间的每一个实数也都属于该区间.例如$(0,2)$是区间而$(0,1)union(1,2)$不是区间,因为它缺少位于其中两点之间的实数1.]\

#h(2em) 下面介绍邻域及其相关概念。\
#bluebar[
  #strong[定义]\

  设 $a in bb(R)$，$delta > 0$。
  以点 $a$ 为中心、半径为 $delta$ 的开区间，
  称为点 $a$ 的 $delta$ 邻域，记作 $U(a; delta)$:

  $ U(a; delta)
    = {x in bb(R) | abs(x-a) < delta}
    = (a-delta, a+delta) $
]

#h(2em) 在此基础上，约定以下记号。

#bluebar[
  #strong[定义]
  #strong[去心邻域与单侧邻域]

  从邻域中去掉中心点 $a$，得到点 $a$ 的
  *去心（空心）$delta$ 邻域*:

  $ U^(circle.small)(a; delta)
    := {x in bb(R) | 0 < abs(x-a) < delta}
    = (a-delta, a) union (a, a+delta) $

  点 $a$ 的 *$delta$ 右邻域*:

  $ U_(+)(a; delta) = [a, a+delta) $

  点 $a$ 的 *$delta$ 左邻域*:

  $ U_(-)(a; delta) = (a-delta, a] $

  从上述单侧邻域中去掉点 $a$，分别得到：

  *点 $a$ 的去心 $delta$ 右邻域*

  $ U_(+)^(circle.small)(a; delta) = (a, a+delta) $

  *点 $a$ 的去心 $delta$ 左邻域*

  $ U_(-)^(circle.small)(a; delta) = (a-delta, a) $
]
#h(2em) 注意:去心邻域 $U^(circle.small)(a; delta)$不是区间，因为它缺少中心点$a$;但去心左邻域和去心右邻域分别都是开区间.邻域的定义旨在用数学语言精确刻画一个点“周围”的范围。面对区间相关问题,我们常常可以将其画在数轴上表示,如下图所示:

#import "@preview/cetz:0.3.4"

// 封装一个通用的邻域数轴绘制函数，保持 6 张图风格 100% 统一
#let draw-nbhd(
  title,
  left-active: true,   // 左半段 (a-δ, a) 是否高亮
  right-active: true,  // 右半段 (a, a+δ) 是否高亮
  left-closed: false,  // 左端点 a-δ 是否实心
  center-State: "closed", // 中心点 a 状态: "closed"(实心), "open"(空心), "tick"(普通刻度)
  right-closed: false, // 右端点 a+δ 是否实心
) = cetz.canvas(length: 0.72cm, {
  import cetz.draw: *
  let blue-main = rgb("#2563eb")
  let red-sub = rgb("#dc2626")
  let gray-axis = gray.darken(30%)

  // 1. 底层实数轴
  line((-3.2, 0), (3.2, 0), mark: (end: ">"), stroke: 0.8pt + gray-axis)
  content((3.5, 0), text(size: 9pt)[$x$])

  // 2. 绘制高亮区间段与顶部半径 δ 标注
  if left-active {
    line((-2.0, 0), (0, 0), stroke: 2.6pt + blue-main)
    line((-2.0, 0.35), (0, 0.35), mark: (start: ">", end: ">"), stroke: 0.6pt + red-sub)
    content((-1.0, 0.68), text(fill: red-sub, size: 8pt)[$delta$])
  }
  if right-active {
    line((0, 0), (2.0, 0), stroke: 2.6pt + blue-main)
    line((0, 0.35), (2.0, 0.35), mark: (start: ">", end: ">"), stroke: 0.6pt + red-sub)
    content((1.0, 0.68), text(fill: red-sub, size: 8pt)[$delta$])
  }

  // 3. 绘制左端点 a - δ
  if left-active {
    circle((-2.0, 0), radius: 0.11, fill: if left-closed { blue-main } else { white }, stroke: 1.4pt + blue-main)
  } else {
    line((-2.0, -0.1), (-2.0, 0.1), stroke: 0.8pt + gray-axis)
  }

  // 4. 绘制右端点 a + δ
  if right-active {
    circle((2.0, 0), radius: 0.11, fill: if right-closed { blue-main } else { white }, stroke: 1.4pt + blue-main)
  } else {
    line((2.0, -0.1), (2.0, 0.1), stroke: 0.8pt + gray-axis)
  }

  // 5. 绘制中心点 a（实心 = 包含 a；空心 = 去心挖掉 a）
  if center-State == "closed" {
    circle((0, 0), radius: 0.11, fill: blue-main, stroke: 1.4pt + blue-main)
  } else if center-State == "open" {
    circle((0, 0), radius: 0.11, fill: white, stroke: 1.4pt + blue-main)
  }

  // 6. 坐标标签与底部标题
  content((-2.0, -0.48), text(size: 8.5pt)[$a - delta$])
  content((0, -0.48), text(size: 8.5pt)[$a$])
  content((2.0, -0.48), text(size: 8.5pt)[$a + delta$])
  content((0, -1.15), text(size: 9pt, fill: black)[#title])
})

// ==================== 6 种邻域全景 2×3 矩阵排版 ====================
#align(center)[
  #block(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 0.6pt + rgb("#cbd5e1"),
    radius: 6pt,
    inset: (x: 8pt, y: 14pt),
    breakable: false, // 保证整张图谱不被分页切断
  )[
    #grid(
      columns: (1fr, 1fr),
      row-gutter: 18pt,
      column-gutter: 10pt,

      // 第 1 行：标准邻域 vs 去心邻域
      draw-nbhd(
        [1. 邻域 $U(a; delta) = (a - delta, a + delta)$],
        left-active: true, right-active: true, center-State: "closed"
      ),
      draw-nbhd(
        [2. 去心邻域 $U^compose (a; delta) = (a - delta, a) union (a, a + delta)$],
        left-active: true, right-active: true, center-State: "open"
      ),

      // 第 2 行：左邻域 vs 右邻域（含中心点 a，故中心点为实心）
      draw-nbhd(
        [3. 左邻域 $U_(-)(a; delta) = (a - delta, a]$],
        left-active: true, right-active: false, center-State: "closed"
      ),
      draw-nbhd(
        [4. 右邻域 $U_(+)(a; delta) = [a, a + delta)$],
        left-active: false, right-active: true, center-State: "closed"
      ),

      // 第 3 行：去心左邻域 vs 去心右邻域（挖掉中心点 a，故中心点为空心）
      draw-nbhd(
        [5. 去心左邻域 $U_(-)^compose (a; delta) = (a - delta, a)$],
        left-active: true, right-active: false, center-State: "open"
      ),
      draw-nbhd(
        [6. 去心右邻域 $U_(+)^compose (a; delta) = (a, a + delta)$],
        left-active: false, right-active: true, center-State: "open"
      ),
    )
  ]
]
== 本节小结与练习
本组练习沿用正文中的数集、集合运算与邻域记号，
默认使用高中阶段的实数四则运算。
自然数集 $NN$ 包含 $0$；
补集相对于各题指定的全集而言；
左右邻域均包含中心点，去心邻域不包含中心点。

说明：满足一个命题的条件、却不满足其结论的具体例子，
称为该命题的一个*反例*。
要说明一个命题并非总是成立，给出一个反例即可。

+ *数集辨认。*
  已知 $alpha$ 是一个无理数。
  判断下列各数分别属于
  $NN$、$ZZ$、$QQ$、$RR$、$RR without QQ$
  中的哪些集合。一个数可以属于多个集合。

  $ -3, quad 0, quad 2/5, quad sqrt(9), quad alpha $

+ *运用不等式的基本性质。*
  设以下字母均表示实数。
  证明下列结论，并说明使用了正文中的哪些性质。

  (1) 若 $a<b$ 且 $c<d$，则 $a+c<b+d$。

  (2) 若 $a<b$ 且 $c<0$，则 $c(a-1)>c(b-1)$。

+ *辨析适用条件。*
  有人认为：只要 $a<b$，就一定有 $a c<b c$。
  其中 $a,b,c$ 均为实数。

  (1) 在 $a<b$ 的条件下，分别讨论
  $c>0$、$c=0$、$c<0$ 时，
  $a c$ 与 $b c$ 的大小关系。

  (2) 给出一组具体的实数 $a,b,c$，
  使 $a<b$ 成立，但 $a c<b c$ 不成立。

+ *有限集合的运算。*
  设全集及两个集合分别为

  $ U={0,1,2,3,4,5,6}, quad
    A={0,2,4,6}, quad B={1,2,3,4}. $

  求下列集合，并用列举法表示结果。

  (1) $A inter B$。

  (2) $A union B$。

  (3) $overline(A)$。

  (4) $A without B$。

  (5) $B without A$。

+ *区间的集合运算。*
  设全集为 $RR$，且

  $ A=(-2,3], quad B=[1,5). $

  用区间或区间的并表示下列集合，
  并在数轴上核对各端点是否保留。

  (1) $A inter B$。

  (2) $A union B$。

  (3) $A without B$。

  (4) $B without A$。

  (5) $overline(A)$。

+ *从定义出发证明集合恒等式。*
  设 $A,B,C subset.eq U$。
  用元素法证明下列等式。

  (1) $A inter (A union B)=A$。

  (2) $A without (B union C)
       =(A without B) inter (A without C)$。

  提示：任取一个元素，说明它属于等式左边的集合，
  当且仅当它属于等式右边的集合。

+ *用反例辨析集合关系。*
  下列说法是否对任意集合都成立？
  若成立，请证明；若不成立，请用具体的有限集合给出反例。

  (1) $A without B=B without A$。

  (2) 若 $A union B=A union C$，则 $B=C$。

+ *把邻域写成区间。*
  用区间或区间的并表示下列六个集合，
  并指出哪些包含中心点 $1$。

  (1) $U(1;2)$。

  (2) $U^(circle.small)(1;2)$。

  (3) $U_(-)(1;2)$。

  (4) $U_(+)(1;2)$。

  (5) $U_(-)^(circle.small)(1;2)$。

  (6) $U_(+)^(circle.small)(1;2)$。

+ *单侧邻域之间的关系。*
  设 $a in RR$，$delta>0$。
  求下列集合，并依据定义说明理由。

  (1) $U_(-)(a;delta) union U_(+)(a;delta)$。

  (2) $U_(-)(a;delta) inter U_(+)(a;delta)$。

  (3) $U_(-)^(circle.small)(a;delta)
       union U_(+)^(circle.small)(a;delta)$。

  (4) $U_(-)^(circle.small)(a;delta)
       inter U_(+)^(circle.small)(a;delta)$。

+ *选择邻域的半径（提高）。*
  分别求出满足下列条件的所有 $delta>0$。
  注意判断所得半径范围的端点是否可以取到。

  (1) $U(1;delta) subset.eq (-1,4)$。

  (2) $U_(+)(1;delta) subset.eq [1,4)$。

  提示：先把邻域写成区间，再比较端点。

= 数学逻辑与基本语言
== 命题与逻辑联结词
=== 命题与真假命题 <sec:211>
#h(2em) 陈述句在现实生活中无处不在,比如:雪是白色的、李白是明朝人、绝缘体是可导电的物质、提出相对论的人是爱因斯坦...不难看出,有些陈述句一眼看上去就是错误的,比如李白是明朝人,与我们已知的事实"李白是唐朝人"相矛盾,这些有真有假的陈述句帮助我们表达信息,由此我们提出“命题”的定义:\
#bluebar[
  #strong[定义]
  命题(proposition)，在逻辑学、哲学、语言学中，是一个#hl[陈述句]所表达的判断，具有真值，即不是真的就是假的
]
#h(2em) 可见,若一个句子要成为一个命题,要满足如下2个条件:#hl[1:句子是陈述句2:在给定语境下,表达具有确定真值的判断]\
#h(2em) 例如,"$2>0$"是一个陈述句,而且可以判断真假，它是一个命题,但是"$x>0$"虽然是一个陈述句,但是由于x变量尚未赋值,也没有受到量词约束,我们无法判断其真假,我们只能称它为含待定变量的条件(开语句),而不是一个严格的命题.
\
#h(2em) 在开头的若干命题中,其内容有真的,有假的,自然的,我们提出真、假命题地定义:
#bluebar[
  #strong[定义]
  #hl[其含义判断为真]的命题叫做真命题;#hl[其含义判断为假]的命题叫做假命题
]
#h(2em) 例如雪是白色的、提出相对论的人是爱因斯坦是真命题;李白是明朝人、绝缘体是可导电的物质是假命题
=== 逻辑联结词
#h(2em) 数之间有加减乘除运算;集合之间有交集、并集、补集、差集计算符号,在命题中,我们也有类似的符号,这类符号叫做逻辑运算符.逻辑运算符的数量很多NOT,AND,NAND,OR等等都是逻辑运算符;#hl[在形式逻辑中，同一个符号，从语句构成的角度看是逻辑联结词，从真值计算的角度看体现为逻辑运算符];下面列举三个常见的逻辑运算符:
#bluebar[
  #strong[定义]
  #align(center)[
  #table(
    columns: (1fr, 2.1fr, 4.5fr,2fr),
    stroke: none,          // 先清空所有默认网格线
    inset: (x: 10pt, y: 8pt),
    align: (center, left, left),

    // 1. 顶部粗线
    table.hline(stroke: 1.5pt + black),
    table.header(          // 使用 table.header 可以在跨页时自动重复表头！
      [*逻辑运算符*], [*名称*], [*特征/定义*], [*应用*]
    ),
    // 2. 表头下方细线
    table.hline(stroke: 0.7pt + black),

    [$not$], [否定-逻辑非(NOT)], [$not p$的真值与$p$相反:$p$真时它假,$p$假时它真],[构造反证法\ 求命题的否定],
    [$and$], [合取-逻辑与(AND)], [当且仅当两者都为真时为真],[联立不等式组\ 定义域取交集],
    [$or$], [析取-逻辑或(OR)], [当且仅当至少一个为真时为真],[定义域合并],

    // 3. 底部粗线
    table.hline(stroke: 1.5pt + black),
  )
]
] 
#h(2em) 需要特别注意的是,逻辑或$or$作为一种二元运算符,允许两元即两个命题同时成立,这似乎很难理解,让我们来看两个例子:\
#h(2em) 若两数乘积为0,即$a b=0$那么就可以推导出$a=0 or b=0$,注意,#hl[如果$a=b=0$,依然成立!]我们再来看一个例子:还记得并集的定义吗?$A union B := {x | x in A or x in B}$如果$A={1,2}$,$B={2,3}$,注意到数字2同时属于集合$A$与$B$,因为运算符$or$允许两个命题都成立,所以数字2自然是A,B的并集{1,2,3}中的元素;#hl[其实,真正必须二选一的逻辑运算符是异或($xor$,排他或)]\
#h(2em) 前面介绍的否定、合取与析取，使我们能够表达“某个命题不成立”“两个命题同时成立”或“至少有一个命题成立”。在数学中，我们还经常使用“若……则……”和“……当且仅当……”这样的表述，用来组织条件与结论。与这两种表述对应的逻辑联结词，分别是蕴含与等价。它们同样是二元逻辑联结词。下面介绍它们的含义，并进一步讨论充分条件、必要条件与充要条件
== 蕴含、等价与条件关系
=== 蕴含
#h(2em) 数学中的许多命题具有“若条件成立，则结论成立”的形式。例如，在实数范围内，“若 $x > 2$，则 $x > 0$”。这里，$x > 2$ 是条件，$x > 0$ 是结论。为了准确理解这类表述，我们先介绍蕴含联结词
#bluebar[
  #strong[定义]\
  #h(2em) 实质蕴涵或蕴涵算子是一种#hl[二元的真值泛函的逻辑运算符],它有着如下形式:\
  #h(2em) #hl[若A,则B.]\
  #h(2em) 在这种形式的陈述中,第一项这里的A,叫做#hl[前件(前提)];第二项这里的B,叫做#hl[后件]\
  #h(2em) 算子使用符号“$->$”来符号化，其语义仅为“如果$A$为真，那么$B$亦为真”即：$A->B$
]
#h(2em) 不知读者是否观察到其与推出符号$==>$很相似,我们常常会混用,但是二者有本质差别,实质蕴含符号常常被用来连接,构造新的复合命题,下面给出一个例子:
#mybox[
  $ "考虑命题P:" 1 + 1 = 3\ "考虑命题Q:太阳从西边出来" $
  #h(2em) 接下来使用蕴涵算子构造复合命题:
  $ P->Q ":" (1 + 1 = 3)->("太阳从西边出来") $
  #h(2em) 让我们来判断这个命题的真假,蕴涵算子的真值表如下:
  #align(center)[
  #table(
    columns: (auto, auto, auto),
    align: center + horizon,
    inset: (x: 10pt, y: 7pt),
    stroke: 0.6pt + rgb("#9aa5b1"),
    fill: (x, y) => if y == 0 {
      rgb("#e6eaee") // 表头浅灰底色
    } else if calc.odd(y) {
      white          // 奇数行白色
    } else {
      rgb("#f6f8fa") // 偶数行微灰斑马纹
    },

    // 表头
    [$A$], [$B$], [*$A -> B$（符合了“如果 $A$ 为真，那么 $B$ 必为真”）*],

    // 数据行
    [F], [F], [T],
    [F], [T], [T],
    [T], [F], [F],
    [T], [T], [T],
  )
  复合命题$P->Q$中,前件$P$为假,命题$P->Q$为真;这是完全合理的!
  ]
  #h(2em) #hl[如果我们换成推出符号$==>$呢?]
  $ (1 + 1 = 3)==>("太阳从西边出来") $
  #align(center)[因为 $1+1=3$，所以我们能推理出太阳从西边出来?!?这是荒谬的]
] 
=== 条件关系
#h(2em) 前面介绍了蕴含联结词及其真值规则。接下来，我们进一步讨论数学命题中条件与结论的关系：在给定的讨论范围内，一个条件成立，是否足以保证另一个条件成立？反过来，后一个条件成立时，前一个条件是否必不可少？ 这就引出了充分条件与必要条件的概念,下面我们来看一个例子：\
#h(2em) 对任意整数 $n$，若$n$ 是4的倍数，则 $n$ 是偶数。因此，#hl[“是4的倍数”足以保证“是偶数”，我们称前者为后者的充分条件。]
从另一个角度看，一个整数要成为4的倍数，就必须是偶数，因此，#hl[“是偶数”是“是4的倍数”的必要条件]\
#h(2em) 下面对充分条件，必要条件作出如下定义:
#bluebar[
  #strong[定义]\
  #h(2em) 在逻辑学中:当命题“若P则Q”为真时,P称为Q的充分条件,Q称为P的必要条件
]
#h(2em) 充分条件强调#hl[“具备它就够了”]，但不表示只有具备它才能得到结论。例如，6是偶数，却不是4的倍数。\
#h(2em) 必要条件强调#hl[“缺少它就不行”]，但不表示具备它就一定能得到结论。例如，一个整数不是偶数，就不可能是4的倍数；但仅仅知道它是偶数，还不能保证它是4的倍数\
\
#h(2em) #hl[注：在数理逻辑文献中，也常用实质蕴含命题 $P -> Q$ 成立（为真）来定义 $P$ 是 $Q$ 的充分条件；而在数学分析中，我们统一用推出符号 $P ==> Q$ 来表示这一条件关系]
=== 等价与充要条件
#h(2em) 上面的条件关系是单向的。如果两个条件能够相互保证，即 $P$成立总能保证 $Q$成立，而 $Q$ 成立也总能保证 $P$ 成立，那么它们之间又是什么关系？这就引出了等价与充要条件\
#bluebar[
  #strong[定义]\
  #h(2em) 对于命题P,Q;其复合命题"P当且仅当Q"计做:
  $ P<->Q $
  #h(2em) #hl[其中$<->$为等价联结词],此二元真值函数运算符的真值表如下:
  #align(center)[
    #table(
      columns: (auto, auto, auto),
      align: center + horizon,
      inset: (x: 10pt, y: 7pt),
      stroke: 0.6pt + rgb("#9aa5b1"),
      fill: (x, y) => if y == 0 {
        rgb("#e6eaee") // 表头浅灰底色
      } else if calc.odd(y) {
        white          // 奇数行白色
      } else {
        rgb("#f6f8fa") // 偶数行微灰斑马纹
      },

      // 表头
      [$P$], [$Q$], [*$P <-> Q$（当且仅当 $P$ 与 $Q$ 真值相同时为真）*],

      // 数据行
      [F], [F], [T],
      [F], [T], [F],
      [T], [F], [F],
      [T], [T], [T],
  )
]
]
#h(2em) 需要特别注意的是如下关系:
#align(center)[
  $P<->Q$与$(P->Q)and(Q->P)$具有相同的真值
]
#h(2em) 由以上的命题我们可以看出: P当且仅当Q由2个部分组成:“若$P$，则 $Q$”与“若 $Q$，则 $P$”\
#h(2em) 上面的讨论建立在逻辑学上,如果我们把这种思想应用于条件关系呢?还记得上面的定义吗？"在逻辑学中:当命题“若P则Q”为真时,P称为Q的充分条件,Q称为P的必要条件",这就自然的引出了充要条件的概念。
#bluebar[
  #strong[定义]\
  #h(2em) 对于命题$P$,$Q$:\
  #h(2em) 当命题“若$P$则$Q$”与“若$Q$则$P$”皆为真时，P是Q的充分必要条件，同时，$Q$也是$P$的充分必要条件,记做:
  $ P <=> Q $
  #h(2em) 此时，也称条件$P$与条件$Q$等价
] 
#h(2em) 因此，下列说法表达相同的条件关系：\
#align(center)[
  $P$是$Q$的充要条件($P<=>Q$)\
  复合命题“$P$ 当且仅当 $Q$”为真（$v(P <-> Q)=T$）\
  $P$与$Q$等价
]
== 量词、变量范围与命题的否定
#h(2em) 前面我们介绍了命题之间的逻辑运算与条件关系。然而，数学中的许多表述还含有变量，例如"$x > 0$"。仅写出这个条件，并没有说明它对哪些对象成立，也没有说明我们要求所有对象都满足它，还是只要求至少有一个对象满足它。为了准确表达这些含义，需要进一步明确变量的取值范围，并引入量词.
=== 变量范围与含变量的条件
#h(2em) 变量的取值范围说明我们讨论哪些对象，但指定范围并不等于指定具体取值。例如，即使约定$x in RR$，仍不能据此确定“$x>0$”的真假，因为实数范围内既有正数，也有零和负数. \
#h(2em) 现在回顾我们在 @sec:211 中说过的一句话:但是"$x>0$"虽然是一个陈述句,但是由于x变量尚未赋值,也没有受到量词约束,我们无法判断其真假,我们只能称它为含待定变量的条件(开语句),而不是一个严格的命题.\
#h(2em) 给$x$不同的值，可能得到不同真值。可以引入一个方便的记法：一元谓词\
#bluebar[
  #strong[定义]\
  #h(2em) 设变量$x$取值范围为$D$。用$P(x)$表示关于$x$的一个条件；对每个$a in D$，代入$x=a$ 后，$P(x)$都是具有确定真值的命题。这样的条件称为关于$x$的一元谓词。
]
#h(2em) 用$P(x)$表示一个含变量$x$的条件。例如，$P(x)$ 可以表示“$x > 0$”。当给 $x$ 指定取值后，就得到一个可以判断真假的命题\
#h(2em) 如果不指定$x$的具体数值，而要表达“范围内所有对象都满足某个条件”或“至少有一个对象满足某个条件”，应该怎样写？
=== 全称量词与存在量词
#h(2em) 为了回答上个小节的问题,我们引入全称量词与存在量词的概念
#bluebar[
  #strong[定义]\
  #table(
    columns: (1fr, 2fr, 2.5fr),
    stroke: none,          // 先清空所有默认网格线
    inset: (x: 12pt, y: 8pt),
    align: (center, left, left),

    // 1. 顶部粗线
    table.hline(stroke: 1.5pt + black),
    table.header(          // 使用 table.header 可以在跨页时自动重复表头！
      [*量词*], [*表述与记号*], [*命题为真的条件*]
    ),
    // 2. 表头下方细线
    table.hline(stroke: 0.7pt + black),

    [$forall$], [对所有$x in D$命题$P(x)$成立\ $forall x in D,P(x)$], [$D$中每个元素都满足该条件],
    [$exists$], [存在$x in D$使命题$P(x)$成立\ $exists x in D,P(x)$], [$D$中至少有一个元素满足该条件],
    // 3. 底部粗线
    table.hline(stroke: 1.5pt + black),
  )
]
#hl[#h(2em) 需要注意的是:$forall x in D,P(x)$;$exists x in D,P(x)$都是命题]\
#h(2em) 下面给出几个例子:\
#mybox[
  $
    v(forall x in RR, x^2 >= 0) &= "T", \
    v(exists x in RR, x^2 = 2) &= "T", \
    v(exists x in ZZ, x^2 = 2) &= "F". 
  $
]
#h(2em) 看了上面三个例子,读者应该理解了两个量词的使用,后两个命题也正好说明变量范围会影响命题的真假\
#h(2em) 需要辨析的是:“任意”要求对#hl[每个对象都成立]，不能只验证几个例子。“存在”表示至少一个，#hl[可以有多个]。#hl[特殊的,“存在且唯一”表示恰好一个，常记作$exists!$,例如$v(exists! x in RR, x^2 = 0) &= "T"$;$v(exists! x in RR, x^2 = 2) &= "F"$]
=== 多重量词的顺序与变量依赖
#h(2em) 请读者关注下面两个命题,他们两个具有相同的真值吗?:\
$ forall x in RR,exists y in RR,y>x $
$ exists y in RR,forall x in RR,y>x $
#h(2em) 乍看上去,似乎是等价的,如果我们把它们翻译成自然语言呢?\
#align(center)[
  对于任意的$x in RR$,存在$y in RR$满足$y>x$\
  存在$y in RR$,使得对于任意的$x in RR$,满足$y>x$
]
#h(2em) 看出区别了吗?#hl[第一个显然为真命题,第二个只要取$x=y+1$就不满足$y>x$];由此可见,量词的先后顺序决定了命题的要求。在“对每个$x$,存在$y$”中,$y$可以根据$x$来选取;在“存在$y$,对每个$x$”中,则要求同一个$y$ 对所有$x$ 都适用（这正是后面学习逐点连续与一致连续的核心区别）.\
=== 含量词命题的否定
#h(2em) 对命题取否定，就是断言原命题不成立。下面讨论如何把含量词命题的否定写成明确的数学表述。\
#h(2em) 对于这个问题,我们不一上来就由公式进行定义,我们先来一个自然语言的例子吧!
#mybox[
  #h(2em) 自然语言:
  #align(center)[方程$x^2+1=0$没有实数解]
  #h(2em) 尝试用包含“有”这个字的句子否定它:
  #align(center)[方程$x^2+1=0$至少有一个实数解]
  \
  \
  \
  #h(2em) 如果我们使用全称与存在量词写着两句话呢?:\
  $ forall x in RR,x^2+1!=0 $
  $ exists x in RR,x^2+1=0 $
]
#h(2em) 看出什么规律了吗？我们在对命题进行否定时把$forall$替换为了$exists$,并且把$x^2+1!=0$否定为了$x^2+1=0$;全称命题不成立，意味着讨论范围内至少有一个对象不满足所述条件；存在命题不成立，意味着讨论范围内没有任何对象满足所述条件，也就是每个对象都不满足该条件。就此,我们对命题的否定的规则作出以下归纳:
#bluebar( stroke: (left: 3.5pt + rgb("#f2f838")) )[
  $
    not (forall x in D, P(x)) &<==> exists x in D, not P(x) \
    not (exists x in D, P(x)) &<==> forall x in D, not P(x)
  $
]
#h(2em) #hl[取否定时，变量的取值范围保持不变，全称量词与存在量词互换，并对量词所作用的整个条件取否定]\
#h(2em) 下面给出几个复杂的例子,为后面极限定义等内容做准备:
#mybox[
  #h(2em) 原自然语言命题: #align(center)[对每一个实数，都存在一个比它大的实数]
  #h(2em) 其自然语言否定命题为: #align(center)[存在一个实数，使所有实数都不大于它]
  #h(2em) 翻译成符号化命题为: #align(center)[$not(forall x in RR,exists y in RR,y>x)<==>exists x in RR,forall y in RR,y<=x$]
]
#h(2em) #hl[需要特别注意的是:逐层取否定时，每个量词都要改变，但量词的先后顺序保持不变]
#mybox[
  原自然语言命题：
  #align(center)[
    对集合 $D$ 中任意两个实数，若前者小于后者，则前者的函数值小于后者的函数值（即 $f$ 在 $D$ 上严格递增）
  ]

  其自然语言否定命题为：
  #align(center)[
    存在集合 $D$ 中的两个实数，满足前者小于后者，*且*前者的函数值大于或等于后者的函数值
  ]

  将上述否定过程翻译为符号表达式：
  $
    not (forall x_1, x_2 in D, (x_1 < x_2 -> f(x_1) < f(x_2)))
    &<==> exists x_1, x_2 in D, not (x_1 < x_2 -> f(x_1) < f(x_2)) \
    &<==> exists x_1, x_2 in D, (x_1 < x_2 and f(x_1) >= f(x_2))
  $
]
#h(2em) #hl[需要特别注意的是:这里用到了蕴含命题的否定等价式 $not (P arrow.r Q) arrow.l.r.double P and not Q$。
要证明 $f$ 在 $D$ 上不是严格递增的，只需证明存在 $x_1, x_2 in D$，使 $x_1 < x_2$ 且 $f(x_1) >= f(x_2)$。
给出这样一对具体的数，就构成了反例。]
== 数学陈述与常用证明方法
== 本节小结与练习
#h(2em) 本节从命题及其真值出发，逐步建立描述条件关系的逻辑语言。首先，用自然语言引入命题、真命题与假命题；随后介绍逻辑联结词，并依据蕴涵联结词所构成的复合命题的真假，定义充分条件与必要条件。在此基础上，通过两个方向的蕴涵与合取运算引入等价联结词，说明相应复合命题为真恰好对应于充分性与必要性同时成立，由此定义充要条件，并将“互为充要条件”称为“条件等价”
