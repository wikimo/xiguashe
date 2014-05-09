<div class="home-index">
  <div class="row">
    <div class="col-xs-12">
      <div class="topic-form comm-form">
        <h4>发表文章</h4>
        
          <%= form_for @topic, html: { multipart: true, role: 'form'} do |f| %>

            <%= render partial: 'public/model_errors', locals: { model_errors: @topic } %>

            <div class="form-group">
              <%= f.text_field :title, class: 'form-control', placeholder: '取个有意思的标题吧……'%>
            </div>
            <div class="form-group">
              <%= f.text_area :content,:cols => 30, :rows => 10,:class => 'form-control',:placeholder => '发挥下你的创作灵感……',"data-provide" => 'markdown'%>
              
            </div>
            <div class="form-group">
              <%= f.file_field :img,:class => 'file-inputs btn btn-default',:title => '上传题图！400x260'%>
              <% unless  @topic.img.url.include?('blank')%>
                <button type="button" class="btn btn-default topic-img-preview" data-container="body" data-toggle="popover" data-placement="right" data-content='<%=topic_photos_helper(@topic)%>' data-original-title="题图预览" title="">题图预览
                </button>
              <%end%>
              
            </div>
            <div class="form-group">
              <div id="error"></div>
            </div>
            <%= f.hidden_field :user_id, value: current_user.id %>

            <%= f.submit '发表', class: 'btn btn-primary' %>
          <% end %>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  $(function(){
    $('.file-inputs').bootstrapFileInput();
    if($('.topic-img-preview'))
      $('.topic-img-preview').popover({'html':true})
  })
</script>
