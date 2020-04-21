<p>博客已萌萌哒运行<span id="since"></span><span class="my-face">(●'◡'●)ﾉ♥</span></p>
<p>{{ theme.footer.custom_text }}</p>
{% set current = date(Date.now(), "YYYY") %}
<p>
	© <span itemprop="copyrightYear">{{ current }}</span> {{ config.title }}.
    {% if theme.footer['powered'] %}
		由 <a href="https://hexo.io/" target="_blank" class="external" rel="nofollow">Hexo</a> 强力驱动.
	{% endif %}
	{% if theme.footer['theme'] %}
    Theme By <a href="https://github.com/aphage" target="_blank" class="external" rel="nofollow">Level6</a> v{{ theme.version }}.
	{% endif %}
    <a href="{{ url_for(theme.footer.sitemap) }}" target="_blank">站点地图</a>.
    {% if theme.footer['theme'] %}
	{{ theme.footer.beian }}.
	{% endif %}
</p>
<p>
	Made with <i class="fas fa-heart throb" style="color: #d43f57;"></i>
	by <span class="author" itemprop="copyrightHolder">{{ theme.footer.copyright || config.author }}</span>.
</p>
