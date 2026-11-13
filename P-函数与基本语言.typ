// 修改这里，就能更新封面信息
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
    "New Computer Modern", // 1. 英文与数字优先用经典学术衬线体（自带，无需安装）
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


// 放在 shared/template.typ 中，替换掉原来的 hl 定义：
#let hl(color: rgb("#fef08a"), body) = {
  // 让高亮块内部的数学公式也自动加上同色背景盒
  show math.equation: it => box(
    fill: color,
    outset: (y: 2.5pt), // 上下稍微外扩一点，和两边汉字的高亮高度完美对齐
    it
  )
  highlight(fill: color, body)
}

// 放在 shared/template.typ 中，替换掉原来的 hl 定义：
#let hlo(color: rgb("#f88432b8"), body) = {
  // 让高亮块内部的数学公式也自动加上同色背景盒
  show math.equation: it => box(
    fill: color,
    outset: (y: 2.5pt), // 上下稍微外扩一点，和两边汉字的高亮高度完美对齐
    it
  )
  highlight(fill: color, body)
}

// 放在 shared/template.typ 中，替换掉原来的 hl 定义：
#let hlb(color: rgb("#32c3f8b8"), body) = {
  // 让高亮块内部的数学公式也自动加上同色背景盒
  show math.equation: it => box(
    fill: color,
    outset: (y: 2.5pt), // 上下稍微外扩一点，和两边汉字的高亮高度完美对齐
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
=== 实数的定义 <sec:111>
#h(2em) #strong[本册的所有研究都建立在#hl[实数(real number)]之上的，所以我们不可避免的要引入实数的概念.]\
#h(2em) 实数分为#strong[有理数(rational number)]和#strong[无理数(irrational number)]两个部分,有理数是可以被表示为两个整数比的数;\

#bluebar[
#h(2em) 即,若一个数$r$满足
$ r=p/q #h(1em) (p,q"均为整数",q!=0) $
#h(2em) 那么我们就称$r$是有理数\
]

#h(2em) 反之,无法写成以上形式的数就是无理数,#hl[有理数和无理数统称为实数],$3/2,1,pi,e,-e$都是一些常见的实数
=== 实数的运算与大小关系
#bluebar( stroke: (left: 3.5pt + rgb("#f2f838")) )[

#h(2em) 公理: 对于两个实数,对其进行和、积运算的结果依然是实数,此条规则是在实数公理系统中有定义的,不必证明\
#h(2em) 性质1: $a<b => a+c<b+c$\
#h(2em) 性质2: $a<b,c>0 => a c < b c$\
#h(2em) 性质3: $a<b,c<0 => a c > b c$\

]

#h(2em) 也就是两边加同一个数,大小关系不变;乘同一个正数,不等号方向不变;乘同一个负数,不等号方向反转;注意到,以上三条性质不属于公理,需要被严格证明,在证明之前,我们需要通过定义引入"$<$"\

#bluebar[
#h(2em) #strong[定义]
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
#h(2em) 依据小于号的定义,得到:
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
#h(2em) 依据小于号定义,得到:
$ a c < b c $
]
\
#mybox[
#h(2em) 下面对#hl[性质3(负数乘法反序性)]:$a<b,c<0 => a c > b c$进行证明:\
#h(2em) #hlb[ #strong[证明]]\
#h(2em) 由已知条件可知:
$ -c in RR^+,b-a in RR^+ $
#h(2em) 根据正数乘法封闭性公理,两者相乘为正数:
$ (b-a) (-c) in RR^+ $
#h(2em) 利用$(-1) (-1)=1$与分配律,化简得到:
$ (b-a) (-c)=a c - b c in RR^+ $
#h(2em) 依据大于号的定义,得到:
$ a c>b c $
]
=== 常用数集
// 放在正文里直接使用的三线表模板
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

    [$NN$], [自然数集\ Natural Number Set], [{0,1,2,3...}],
    [$ZZ$], [整数集\ Zahlen(德语)], [$ZZ^- union NN$,{...-2,-1,0,1,2...}],
    [$QQ$], [有理数集\ Quotient], [见上文定义(@sec:111)],
    [$RR$], [实数集\ Real Number Set], [见上文定义(@sec:111)],

    // 3. 底部粗线
    table.hline(stroke: 1.5pt + black),
  )
]
== 集合的运算

=== 集合运算的定义
#h(2em) 下面定义四种常见的集合运算
#bluebar[
#h(2em) #strong[定义]
#align(center)[
  #table(
    columns: (0.8fr, 1.8fr, 1.4fr),
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
    [$overline(A)$], [$overline(A) := {x in U | x in.not A} = U without A$], [$"在U上取补集"$],
    [$A without B$], [$A without B := {x | x in A and x in.not B}$], [$"差集,高中课本无此定义"$],
    // 3. 底部粗线
    table.hline(stroke: 1.5pt + black),
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
x in overline(A union B)
  &<=> x in.not (A union B) \
  &<=> x in.not A and x in.not B \
  &<=> x in overline(A) and x in overline(B) \
  &<=> x in overline(A) inter overline(B)
$
#h(2em) 所以:
$ overline(A union B)=overline(A) inter overline(B) $
]
\
#mybox[
#h(2em) 下面对#hl[德摩根律2]:$overline(A inter B)=overline(A) union overline(B)$进行证明:\
#h(2em) #hlb[ #strong[证明]]\
$
x in overline(A inter B)
  &<=> x in.not (A inter B) \
  &<=> x in.not A or x in.not B \
  &<=> x in overline(A) or x in overline(B) \
  &<=> x in overline(A) union overline(B)
$
#h(2em) 所以:
$ overline(A inter B)=overline(A) union overline(B) $
]
#h(2em) 其他若干种定律也可以通过类似的方法进行证明,这里不再赘述,留给读者自行证明

== 区间与临域

== 取值范围的表示与转换
== 本节小结与练习