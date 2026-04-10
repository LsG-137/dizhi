import Foundation

class DataProvider: ObservableObject  {
    static let shared = DataProvider()

    private(set) var places: [Place] = []

    private init() {
        loadAllPlaces()
        StorageManager.shared.syncWithDataProvider(places: &places)
    }

    private func loadAllPlaces() {
        // 自己的收藏 (isOwn: true)
        let ownPlaces = [
            // 云南
            Place(name: "石屏异龙湖国家湿地公园", province: "云南", category: .nature, description: "一片湖，候鸟比人更早知道它的存在", isOwn: true),
            Place(name: "苍山景区-洗马潭索道", province: "云南", category: .nature, description: "云在山腰，人在云里", isOwn: true),
            Place(name: "崇圣寺三塔文化旅游区", province: "云南", category: .temple, description: "三座塔站了一千年，看着大理换了无数朝代", isOwn: true),
            Place(name: "巍山古城", province: "云南", category: .ancient, description: "南诏国的起点，现在安静得像被历史遗忘", isOwn: true),
            Place(name: "滇池海埂公园", province: "云南", category: .nature, description: "昆明的海，红嘴鸥每年冬天准时赴约", isOwn: true),
            Place(name: "圆通禅寺", province: "云南", category: .temple, description: "昆明城里最古老的寺，春天樱花开在佛前", isOwn: true),
            Place(name: "澄江化石地世界自然遗产博物馆", province: "云南", category: .museum, description: "五亿年前的生命，安静地躺在玻璃后面", isOwn: true),
            Place(name: "抚仙湖国家级旅游度假区", province: "云南", category: .nature, description: "云南最深的湖，深到装得下一座古城", isOwn: true),

            // 四川
            Place(name: "青城山景区", province: "四川", category: .nature, description: "道教第五洞天，雨雾里的山比晴天更像仙境", isOwn: true),
            Place(name: "三星堆博物馆", province: "四川", category: .museum, description: "一个完全陌生的文明，突然从土里冒出来", isOwn: true),
            Place(name: "毗卢洞文物景区", province: "四川", category: .cave, description: "安岳石刻里最世俗的一处，柳本尊的故事刻在岩壁上", isOwn: true),
            Place(name: "槽渔滩风景名胜区千塔佛国", province: "四川", category: .temple, description: "水边的石塔群，像一场没有结束的仪式", isOwn: true),
            Place(name: "荣县大佛文化旅游区", province: "四川", category: .cave, description: "唐代大佛，比乐山小，比乐山安静", isOwn: true),
            Place(name: "马边明王寺", province: "四川", category: .temple, description: "深山里的寺，去的人不多，佛却不少", isOwn: true),
            Place(name: "江口沉银博物馆", province: "四川", category: .museum, description: "张献忠的宝藏，在江底沉了三百年", isOwn: true),
            Place(name: "皇泽寺景区", province: "四川", category: .cave, description: "武则天的家乡，北魏石窟在嘉陵江边看了一千五百年", isOwn: true),
            Place(name: "千佛崖", province: "四川", category: .cave, description: "广元城边，摩崖造像密密麻麻，像一部刻在石头上的经文", isOwn: true),

            // 西藏
            Place(name: "大昭寺", province: "西藏", category: .temple, description: "拉萨的心脏，磕长头的人从四面八方来到这里", isOwn: true),
            Place(name: "罗布林卡", province: "西藏", category: .heritage, description: "达赖喇嘛的夏宫，藏式园林里的安静下午", isOwn: true),
            Place(name: "西藏博物馆", province: "西藏", category: .museum, description: "高原文明的容器", isOwn: true),

            // 青海
            Place(name: "塔尔寺", province: "青海", category: .temple, description: "宗喀巴大师的出生地，酥油花是这里最短暂的艺术", isOwn: true),
            Place(name: "西宁东关清真大寺", province: "青海", category: .temple, description: "西北最大的清真寺，礼拜时间整座城市都能听见", isOwn: true),

            // 福建
            Place(name: "南少林寺", province: "福建", category: .temple, description: "武术的另一个源头，莆田山里", isOwn: true),
            Place(name: "南山广化寺", province: "福建", category: .temple, description: "莆田千年古刹，律宗道场", isOwn: true),
            Place(name: "南普陀寺", province: "福建", category: .temple, description: "厦门大学旁边，香火与书卷气混在一起", isOwn: true),
            Place(name: "泉州开元寺", province: "福建", category: .temple, description: "宋元泉州的精神中心，两棵古桑树还在", isOwn: true),
            Place(name: "安平桥", province: "福建", category: .heritage, description: "八百年前造的桥，还在海上", isOwn: true),
            Place(name: "福建土楼(南靖)田螺坑景区", province: "福建", category: .heritage, description: "从山上看下去，四个圆围着一个方", isOwn: true),
            Place(name: "三坊七巷", province: "福建", category: .ancient, description: "福州的文脉，半部中国近代史从这里走出", isOwn: true),
            Place(name: "福道", province: "福建", category: .nature, description: "悬在山间的步道，城市与森林的边界", isOwn: true),
            Place(name: "烟台山公园", province: "福建", category: .ancient, description: "福州的领事馆山，近代史的另一面", isOwn: true),
            Place(name: "福建博物院", province: "福建", category: .museum, description: "闽越文化的收藏地", isOwn: true),
            Place(name: "鹅尾海蚀地质公园", province: "福建", category: .nature, description: "湄洲岛南端，海浪把石头雕成了兽", isOwn: true),
            Place(name: "台山岛", province: "福建", category: .nature, description: "福鼎外海，远到需要坐船，安静到值得", isOwn: true),
            Place(name: "飞云崖", province: "福建", category: .nature, description: "贵州明代摩崖，山水与石刻之间", isOwn: true),

            // 河南
            Place(name: "少林寺", province: "河南", category: .temple, description: "禅宗祖庭，武术只是它最表面的一层皮", isOwn: true),
            Place(name: "三皇寨", province: "河南", category: .nature, description: "嵩山深处，比少林寺更难到达，也更安静", isOwn: true),
            Place(name: "巩义石窟寺", province: "河南", category: .cave, description: "北魏皇家石窟，伊洛河边，游客极少", isOwn: true),
            Place(name: "康百万庄园", province: "河南", category: .ancient, description: "豫商的顶点，留下来的是建筑", isOwn: true),
            Place(name: "河南博物院", province: "河南", category: .museum, description: "中原文明最重要的容器", isOwn: true),
            Place(name: "云台山风景名胜区", province: "河南", category: .nature, description: "太行山的水，绿得不像真的", isOwn: true),
            Place(name: "芒砀山旅游区", province: "河南", category: .ancient, description: "汉高祖斩蛇起义的地方，汉代王陵在山里", isOwn: true),
            Place(name: "灵泉寺石窟", province: "河南", category: .cave, description: "安阳，北齐石窟，和响堂山是同一条线", isOwn: true),

            // 山东
            Place(name: "青州博物馆", province: "山东", category: .museum, description: "北齐佛像出土地，微笑了一千五百年", isOwn: true),
            Place(name: "曲阜三孔景区", province: "山东", category: .heritage, description: "儒家文明的原点，比想象中更安静", isOwn: true),

            // 浙江
            Place(name: "鲁迅故里", province: "浙江", category: .ancient, description: "绍兴，文字比故居更长久", isOwn: true),
            Place(name: "天一阁博物院", province: "浙江", category: .museum, description: "中国现存最古老的私家藏书楼", isOwn: true),
            Place(name: "普陀山风景名胜区", province: "浙江", category: .temple, description: "观音的道场，海上的山", isOwn: true),
            Place(name: "保国寺景区", province: "浙江", category: .temple, description: "宁波，北宋木构建筑，没有一根钉子", isOwn: true),

            // 江西
            Place(name: "龙虎山国家级旅游风景区", province: "江西", category: .nature, description: "道教正一派祖庭，丹霞山水", isOwn: true),
            Place(name: "三清山国家级旅游风景区", province: "江西", category: .nature, description: "花岗岩峰林，云雾是标配", isOwn: true),
            Place(name: "庐山国家级旅游风景名胜区", province: "江西", category: .nature, description: "不识庐山真面目，只缘身在此山中", isOwn: true),

            // 重庆
            Place(name: "大足石刻名胜风景区", province: "重庆", category: .cave, description: "宋代石窟的顶点，世俗生活刻进了佛龛", isOwn: true),

            // 湖北
            Place(name: "武当山风景区", province: "湖北", category: .temple, description: "道教武当派祖庭，金顶在云上", isOwn: true),
            Place(name: "神农架国家级自然保护区", province: "湖北", category: .nature, description: "华中屋脊，野人的传说只是它最浅的一层", isOwn: true),

            // 河北
            Place(name: "正定古城", province: "河北", category: .ancient, description: "北方的小敦煌，四座古塔还在", isOwn: true),
            Place(name: "毗卢寺", province: "河北", category: .temple, description: "石家庄，明代壁画五百罗汉，色彩还在", isOwn: true),

            // 山西
            Place(name: "五台山风景名胜区", province: "山西", category: .temple, description: "文殊菩萨道场，五座台顶各有一座寺", isOwn: true),
            Place(name: "双林寺", province: "山西", category: .temple, description: "平遥旁边，彩塑比壁画更震撼", isOwn: true),

            // 陕西
            Place(name: "石羊镇虎头山", province: "陕西", category: .nature, description: "大理石羊镇，低调的山", isOwn: true),

            // 广东
            Place(name: "惠州西湖风景名胜区", province: "广东", category: .nature, description: "苏东坡贬谪之地，西湖因他而有了文人气质", isOwn: true),
            Place(name: "南沙天后宫", province: "广东", category: .temple, description: "珠江口，妈祖在海边看着来往的船", isOwn: true),
            Place(name: "大华兴寺", province: "广东", category: .temple, description: "深圳东部华侨城里的寺", isOwn: true),
            Place(name: "凤凰山森林公园", province: "广东", category: .nature, description: "深圳宝安，城市边缘的山", isOwn: true),

            // 江苏
            Place(name: "苏州园林", province: "江苏", category: .heritage, description: "拙政园，一座园子就是一个世界观", isOwn: true),

            // 安徽
            Place(name: "西递古村落", province: "安徽", category: .heritage, description: "徽州，白墙黑瓦，马头墙是天际线", isOwn: true),

            // 贵州
            Place(name: "飞云崖", province: "贵州", category: .nature, description: "黔东南，明代摩崖，山水之间", isOwn: true),

            // 上海
            Place(name: "静安寺", province: "上海", category: .temple, description: "闹市里的寺，香火与地铁共存", isOwn: true),

            // 辽宁
            Place(name: "大孤山国家森林公园", province: "辽宁", category: .nature, description: "东港，黄海边的山", isOwn: true),

            // 天津
            Place(name: "独乐寺", province: "天津", category: .temple, description: "蓟州，辽代木构，观音阁是中国现存最古老的木构楼阁之一", isOwn: true),

            // 宁夏
            Place(name: "塔山旅游风景区", province: "宁夏", category: .nature, description: "博兴，山东的塔山", isOwn: true)
        ]

        // 推荐地点 (isOwn: false)
        let recommendedPlaces = [
            // 甘肃
            Place(name: "莫高窟", province: "甘肃", category: .cave, description: "一千年的信仰，画在沙漠边缘的洞窟里", isOwn: false),
            Place(name: "麦积山石窟", province: "甘肃", category: .cave, description: "泥塑比石雕更柔软，更接近人", isOwn: false),
            Place(name: "炳灵寺石窟", province: "甘肃", category: .cave, description: "坐船进去，西秦时期的造像在水边等了一千六百年", isOwn: false),

            // 新疆
            Place(name: "克孜尔石窟", province: "新疆", category: .cave, description: "中国最早的石窟，早于敦煌，龟兹文明的眼睛", isOwn: false),
            Place(name: "交河故城", province: "新疆", category: .ancient, description: "从山体直接挖出来的城，没有一块砖", isOwn: false),
            Place(name: "喀什老城", province: "新疆", category: .ancient, description: "中亚伊斯兰建筑的活化石，时间在这里慢下来", isOwn: false),

            // 内蒙古
            Place(name: "辽上京遗址", province: "内蒙古", category: .ancient, description: "契丹帝国的首都，荒草里的地基", isOwn: false),
            Place(name: "美岱召", province: "内蒙古", category: .temple, description: "汉藏蒙三种风格融合的明代寺庙，极少人去", isOwn: false),
            Place(name: "阴山岩画", province: "内蒙古", category: .heritage, description: "史前人类的涂鸦，绵延数百公里", isOwn: false),

            // 山西
            Place(name: "云冈石窟", province: "山西", category: .cave, description: "北魏皇家石窟，昙曜五窟是中国石窟的开端", isOwn: false),
            Place(name: "悬空寺", province: "山西", category: .temple, description: "北魏始建，挂在恒山峭壁上，建筑本身就是奇迹", isOwn: false),
            Place(name: "广胜寺", province: "山西", category: .temple, description: "洪洞，元代壁画《水神庙》是中国最重要的世俗壁画", isOwn: false),

            // 陕西
            Place(name: "法门寺地宫", province: "陕西", category: .temple, description: "佛指舍利所在，地宫出土文物改写了唐代史", isOwn: false),
            Place(name: "彬州大佛寺石窟", province: "陕西", category: .cave, description: "唐代石窟，关中最重要的石窟，游客极少", isOwn: false),
            Place(name: "统万城遗址", province: "陕西", category: .ancient, description: "匈奴赫连勃勃的都城，白色土城墙，荒漠中的幽灵", isOwn: false),

            // 宁夏
            Place(name: "须弥山石窟", province: "宁夏", category: .cave, description: "固原，北魏至唐，六盘山里的石窟", isOwn: false),
            Place(name: "西夏王陵", province: "宁夏", category: .ancient, description: "神秘消失的西夏文明，土丘群有末日感", isOwn: false),

            // 河南
            Place(name: "龙门石窟", province: "河南", category: .cave, description: "北魏至唐，伊河两岸的佛龛，卢舍那大佛的微笑", isOwn: false),
            Place(name: "白马寺", province: "河南", category: .temple, description: "中国第一座官方佛教寺庙，佛教东传的起点", isOwn: false),
            Place(name: "殷墟", province: "河南", category: .ancient, description: "商代都城，甲骨文出土地，文明的起点", isOwn: false),

            // 山东
            Place(name: "云门山石窟", province: "山东", category: .cave, description: "青州附近，北齐摩崖大佛", isOwn: false),
            Place(name: "灵岩寺", province: "山东", category: .temple, description: "泰山附近，宋代彩塑罗汉，天下第一塑", isOwn: false),
            Place(name: "沂南北寨汉墓", province: "山东", category: .ancient, description: "东汉画像石墓，汉代生死观的图像志", isOwn: false),

            // 河北
            Place(name: "响堂山石窟", province: "河北", category: .cave, description: "邯郸，北齐皇家石窟", isOwn: false),
            Place(name: "赵州桥", province: "河北", category: .heritage, description: "隋代石桥，世界现存最古老的石拱桥", isOwn: false),
            Place(name: "承德外八庙", province: "河北", category: .temple, description: "清代藏传佛教建筑群，微缩的朝圣地图", isOwn: false),

            // 北京
            Place(name: "云居寺", province: "北京", category: .temple, description: "房山，刻经石板一万余块，刻了一千年", isOwn: false),
            Place(name: "周口店遗址", province: "北京", category: .ancient, description: "北京猿人发现地，人类起源的坐标", isOwn: false),

            // 辽宁
            Place(name: "朝阳北塔", province: "辽宁", category: .temple, description: "三燕至唐的地宫，历史层叠感极强", isOwn: false),
            Place(name: "义县奉国寺", province: "辽宁", category: .temple, description: "辽代大殿，中国现存最大的辽代木构建筑", isOwn: false),
            Place(name: "五女山山城", province: "辽宁", category: .ancient, description: "高句丽早期都城，山顶石城", isOwn: false),

            // 吉林
            Place(name: "集安高句丽王城及王陵", province: "吉林", category: .heritage, description: "世界遗产，壁画墓，东北亚文明的起点", isOwn: false),
            Place(name: "长白山天池", province: "吉林", category: .nature, description: "火山口湖，天池在云上", isOwn: false),

            // 黑龙江
            Place(name: "渤海国上京龙泉府遗址", province: "黑龙江", category: .ancient, description: "唐代渤海国都城，东北最重要的古代都城遗址", isOwn: false),
            Place(name: "五大连池火山地质公园", province: "黑龙江", category: .nature, description: "中国保存最完整的火山地貌", isOwn: false),

            // 上海
            Place(name: "龙华寺", province: "上海", category: .temple, description: "上海最古老的寺庙，三国时期始建", isOwn: false),
            Place(name: "上海博物馆", province: "上海", category: .museum, description: "青铜器收藏顶级，中国古代文明的精华", isOwn: false),
            Place(name: "松江唐经幢", province: "上海", category: .heritage, description: "上海最古老的地面文物，几乎没人知道", isOwn: false),

            // 江苏
            Place(name: "南京栖霞寺石窟", province: "江苏", category: .cave, description: "南朝石窟，千佛岩，江南最重要的石窟", isOwn: false),
            Place(name: "徐州汉墓群", province: "江苏", category: .ancient, description: "狮子山楚王陵，汉代诸侯王墓", isOwn: false),

            // 浙江
            Place(name: "新昌大佛寺", province: "浙江", category: .cave, description: "南朝石弥勒，中国最早的大型石窟造像之一", isOwn: false),
            Place(name: "龙游石窟", province: "浙江", category: .cave, description: "来历不明的地下石窟群，至今是谜", isOwn: false),
            Place(name: "国清寺", province: "浙江", category: .temple, description: "天台山，天台宗祖庭，日本佛教的源头", isOwn: false),

            // 安徽
            Place(name: "棠樾牌坊群", province: "安徽", category: .heritage, description: "歙县，七座牌坊，徽州文化的石头叙事", isOwn: false),
            Place(name: "花山谜窟", province: "安徽", category: .cave, description: "屯溪，人工地下石窟，来历成谜", isOwn: false),

            // 江西
            Place(name: "通天岩石窟", province: "江西", category: .cave, description: "赣州，唐宋石窟，江南最大石窟群", isOwn: false),
            Place(name: "吴城遗址", province: "江西", category: .ancient, description: "樟树，商代遗址，长江以南最重要的青铜文明遗址", isOwn: false),

            // 湖南
            Place(name: "里耶古城遗址", province: "湖南", category: .ancient, description: "秦代简牍出土地，改写了对秦朝的认知", isOwn: false),
            Place(name: "南岳衡山", province: "湖南", category: .nature, description: "五岳之南，你走过嵩山，衡山在等你", isOwn: false),
            Place(name: "老司城遗址", province: "湖南", category: .heritage, description: "土家族古都，世界遗产，湘西深处", isOwn: false),

            // 湖北
            Place(name: "随州曾侯乙墓", province: "湖北", category: .museum, description: "编钟出土地，战国音乐文明的顶点", isOwn: false),
            Place(name: "恩施唐崖土司城", province: "湖北", category: .heritage, description: "世界遗产，和老司城是同一条土司文化线", isOwn: false),

            // 重庆
            Place(name: "涞滩石窟", province: "重庆", category: .cave, description: "合川，宋代石窟，精美而冷门", isOwn: false),
            Place(name: "白鹤梁题刻", province: "重庆", category: .heritage, description: "涪陵，水下石刻，世界最早的水文站", isOwn: false),
            Place(name: "钓鱼城遗址", province: "重庆", category: .ancient, description: "蒙古大汗蒙哥战死之地，改变世界历史走向的山城", isOwn: false),

            // 贵州
            Place(name: "梵净山", province: "贵州", category: .nature, description: "弥勒菩萨道场，世界遗产，贵州最重要的佛教圣山", isOwn: false),
            Place(name: "海龙屯土司遗址", province: "贵州", category: .heritage, description: "世界遗产，播州杨氏土司山城", isOwn: false),
            Place(name: "镇远古城", province: "贵州", category: .ancient, description: "舞阳河边，明清驿道上的时间胶囊", isOwn: false),

            // 广西
            Place(name: "花山岩画", province: "广西", category: .heritage, description: "世界遗产，骆越人的史前岩画，和阴山岩画遥相呼应", isOwn: false),
            Place(name: "靖江王府及王陵", province: "广西", category: .ancient, description: "桂林，明代藩王遗址", isOwn: false),
            Place(name: "真武阁", province: "广西", category: .heritage, description: "容县，纯木结构，无钉无铆，中国古建筑奇迹", isOwn: false),

            // 广东
            Place(name: "南华寺", province: "广东", category: .temple, description: "韶关，禅宗六祖慧能道场，中国禅宗最重要的祖庭", isOwn: false),
            Place(name: "开平碉楼", province: "广东", category: .heritage, description: "世界遗产，华侨建筑，中西融合的独特产物", isOwn: false),
            Place(name: "潮州古城", province: "广东", category: .ancient, description: "韩江边，广济桥、开元寺，比泉州更安静", isOwn: false),

            // 海南
            Place(name: "东坡书院", province: "海南", category: .ancient, description: "儋州，苏轼被贬之地，文人流放史的坐标", isOwn: false),
            Place(name: "崖州古城", province: "海南", category: .ancient, description: "三亚，汉代珠崖郡故地，海南最古老的城市遗址", isOwn: false),

            // 云南
            Place(name: "剑川石宝山石窟", province: "云南", category: .cave, description: "南诏国时期，有世俗化的佛像和情爱题材，独一无二", isOwn: false),
            Place(name: "元谋土林", province: "云南", category: .nature, description: "黄色土柱群，和澄江化石地是同一条地质叙事线", isOwn: false),
            Place(name: "沙溪古镇", province: "云南", category: .ancient, description: "茶马古道上被遗忘的驿站，兴教寺壁画还在", isOwn: false),

            // 四川
            Place(name: "夹江千佛岩", province: "四川", category: .cave, description: "乐山附近，唐代石窟，游客极少", isOwn: false),
            Place(name: "平武报恩寺", province: "四川", category: .temple, description: "明代寺庙建筑群，深山故宫，极少人知道", isOwn: false),

            // 西藏
            Place(name: "扎什伦布寺", province: "西藏", category: .temple, description: "日喀则，班禅喇嘛驻锡地，规模不输布达拉宫", isOwn: false),
            Place(name: "托林寺", province: "西藏", category: .temple, description: "阿里，西藏最古老寺庙之一，残破壁画，到达本身就是朝圣", isOwn: false),
            Place(name: "雍布拉康", province: "西藏", category: .ancient, description: "西藏第一座宫殿，山顶，俯瞰雅鲁藏布江河谷", isOwn: false),

            // 青海
            Place(name: "瞿昙寺", province: "青海", category: .temple, description: "乐都，明代汉藏结合寺庙，壁画保存极好，小故宫", isOwn: false),
            Place(name: "热贡艺术（同仁）", province: "青海", category: .museum, description: "唐卡发源地，活着的宗教艺术传统", isOwn: false),

            // 甘肃（补充）
            Place(name: "炳灵寺石窟", province: "甘肃", category: .cave, description: "坐船进去，西秦时期的造像在水边等了一千六百年", isOwn: false)
        ]

        places = ownPlaces + recommendedPlaces
    }

    func places(for province: String) -> [Place] {
        places.filter { $0.province == province }
    }

    func allProvinces() -> [String] {
        Array(Set(places.map { $0.province })).sorted()
    }

    func updateVisitStatus(for placeId: UUID, isVisited: Bool) {
        if let index = places.firstIndex(where: { $0.id == placeId }) {
            places[index].isVisited = isVisited
            // 这里可以添加UserDefaults保存逻辑
            StorageManager.shared.updateVisitStatus(for: placeId, isVisited: isVisited)
        }
    }

    func statistics() -> (total: Int, visited: Int, notVisited: Int) {
        let total = places.count
        let visited = places.filter { $0.isVisited }.count
        let notVisited = total - visited
        return (total, visited, notVisited)
    }

    func provinceStatistics(for province: String) -> (total: Int, visited: Int, notVisited: Int) {
        let provincePlaces = places(for: province)
        let total = provincePlaces.count
        let visited = provincePlaces.filter { $0.isVisited }.count
        let notVisited = total - visited
        return (total, visited, notVisited)
    }

    // 专题路线数据
    struct ThemeRoute {
        let title: String
        let emoji: String
        let placeNames: [String]
    }

    func themeRoutes() -> [ThemeRoute] {
        return [
            ThemeRoute(
                title: "石窟之路",
                emoji: "🪨",
                placeNames: ["克孜尔石窟", "莫高窟", "麦积山石窟", "炳灵寺石窟", "须弥山石窟", "云冈石窟", "龙门石窟", "巩义石窟寺", "响堂山石窟", "千佛崖", "大足石刻名胜风景区", "毗卢洞文物景区", "皇泽寺景区", "夹江千佛岩", "剑川石宝山石窟", "南京栖霞寺石窟", "新昌大佛寺", "通天岩石窟", "涞滩石窟"]
            ),
            ThemeRoute(
                title: "寺庙朝圣",
                emoji: "⛩",
                placeNames: ["高野山", "大昭寺", "塔尔寺", "托林寺", "五台山风景名胜区", "少林寺", "武当山风景区", "南少林寺", "南山广化寺", "南普陀寺", "泉州开元寺", "静安寺", "独乐寺", "法门寺地宫", "灵岩寺", "国清寺", "南华寺", "扎什伦布寺", "瞿昙寺"]
            ),
            ThemeRoute(
                title: "消失的都城",
                emoji: "🏯",
                placeNames: ["交河故城", "统万城遗址", "辽上京遗址", "渤海国上京龙泉府遗址", "殷墟", "巍山古城", "三坊七巷", "正定古城", "周口店遗址", "里耶古城遗址", "钓鱼城遗址", "镇远古城", "潮州古城", "沙溪古镇", "雍布拉康"]
            ),
            ThemeRoute(
                title: "世界遗产线",
                emoji: "🌍",
                placeNames: ["澄江化石地世界自然遗产博物馆", "西递古村落", "武夷山", "大足石刻名胜风景区", "花山岩画", "土司遗址", "安平桥", "福建土楼(南靖)田螺坑景区", "曲阜三孔景区", "苏州园林", "集安高句丽王城及王陵", "开平碉楼", "梵净山", "海龙屯土司遗址", "老司城遗址", "恩施唐崖土司城", "白鹤梁题刻", "真武阁"]
            )
        ]
    }
}
