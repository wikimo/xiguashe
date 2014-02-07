开发规范：

1、controller需保持简单，所有业务处理放到model中

2、view需要保持简单，最多只有一条if语句，若有else，则将该段代码放入到对应的helper中。

3、partial的使用方法：
    以往我们的写法：
    
        index:
        ``
        render partial 'topics', locals: {topics: @topics }
        ``

        _topics: 

        ``
        topics.each do |topic|
            topic.title.....
        end
        ``
    
    现在的写法：

        index: ``render partial: 'topics', collection: @topics, as: :topic

        _topics: ``topic.title.....
    

   这样的写法可以少写一条each语句，还可以提升性能。

4、避免n+1次查询
   在查询时若需要获取相关表的数据需：
   ``
   topics = Topic.includes(:user).scope.....
   ``

