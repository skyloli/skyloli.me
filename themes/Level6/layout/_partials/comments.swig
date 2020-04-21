{% if page.comments %}
	{% if theme.disqus.enable %}
    <div class="comments" id="comments">
      <div id="disqus_thread">
        <div id="dsqjs">
          <section class="dsqjs-info">
            <p id="dsqjs-load-disqus" class="dsqjs-message">评论完整模式加载中...如果长时间无法加载，请针对 disq.us | disquscdn.com | disqus.com 启用代理</p>
          </section>
        </div>
      </div>
    </div>
	<script type="text/javascript">
        window.DISQUS = null;
        new DisqusJS({
          shortname: '{{ theme.disqus.shortname }}',
          siteName: '{{ config.title }}',
          identifier: '{{ page.path }}',
          url: '{{ page.permalink }}',
          api: '{{ theme.disqus.api }}',
          apikey: '{{ theme.disqus.apikey }}',
          admin: '{{ theme.disqus.admin }}',
          adminLabel: '{{ theme.disqus.adminLabel }}',
        });
    </script>
	{% endif %}

{% endif %}