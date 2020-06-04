{% macro render(post, is_index) %}
	{% set post_class = 'post' %}
	<article class="{{ post_class }}" itemscope itemtype="http://schema.org/Article">
	{##################}
	{### POST BLOCK ###}
	{##################}
	<div class="post-date">
		<div class="post-month">{{ date(post.date, 'MM') }}月</div>
		<div class="post-day">{{ date(post.date, 'DD') }}</div>
	</div>
	
	{##这里分类##}
	{% if post.categories and post.categories.length and theme.post_meta.categories %}
	<div class="post-badge">
	{% for cat in post.categories %}
	  <span itemprop="about" itemscope itemtype="http://schema.org/Thing">
		<a href="{{ url_for(cat.path) }}" itemprop="url" rel="index">
		  <span itemprop="name">{{ cat.name }}</span>
		</a>
	  </span>
	{% endfor %}
	</div>
	{% endif %}
	
	<div class="post-block">
		<link itemprop="mainEntityOfPage" href="{{ config.url }}{{ url_for(post.path) }}">
		<span hidden itemprop="author" itemscope itemtype="http://schema.org/Person">
		  <meta itemprop="name" content="{{ theme.author }}">
		  <meta itemprop="description" content="{{ theme.description }}">
		  <meta itemprop="image" content="{{ url_for( theme.avatar || 'images/aphage.png' ) }}">
		</span>
		
		<span hidden itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
		  <meta itemprop="name" content="{{ config.title }}">
		</span>
		<header class="post-header">
			{# 标题 #}
			<h1 class="post-title" itemprop="name headline">
            {% if is_index %}
				<a class="post-title-link scaleup" href="{{ url_for(post.path) }}" itemprop="url">
				{{ post.title | default(__('post.untitled'))}}
				</a>
			{% else %}
				{{ post.title }}
			{% endif %}
			</h1>
			
			{# 创建时间说明 #}
			<div class="post-meta">
			  <span class="post-time">
				{% if theme.post_meta.created_at %}
				  <span class="post-meta-item-icon">
					<i class="far fa-calendar"></i>
				  </span>
				  {% if theme.post_meta.item_text %}
					<span class="post-meta-item-text">{{ __('post.posted') }}</span>
				  {% endif %}
				  <time title="{{ __('post.created') }}" itemprop="dateCreated datePublished" datetime="{{ moment(post.date).format() }}">{{ date(post.date, config.date_format) }}</time>
				{% endif %}

				{% if theme.post_meta.created_at and theme.post_meta.updated_at %}
				  <span class="post-meta-divider">•</span>
				{% endif %}

				{% if theme.post_meta.updated_at %}
				  <span class="post-meta-item-icon">
					<i class="fa fa-calendar-check-o"></i>
				  </span>
				  {% if theme.post_meta.item_text %}
					<span class="post-meta-item-text">{{ __('post.modified') }}&#58;</span>
				  {% endif %}
				  <time title="{{ __('post.modified') }}" itemprop="dateModified" datetime="{{ moment(post.updated).format() }}">
					{{ date(post.updated, config.date_format) }}
				  </time>
				{% endif %}
			  </span>
			</div>
		</header>
		
		
		{#################}
		{### POST BODY ###}
		{#################}
		<div class="post-body" itemprop="articleBody">
		{% if is_index %}
			{% if post.excerpt  %}
			{{ post.excerpt }}
			{% else %}
			{{ post.content }}
			{% endif %}
			 <div class="post-button text-center">
				<a class="btn scaleup" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}#{{ __('post.more') }}{% endif %}" rel="contents">
				  {{ __('post.read_more') }} &raquo;
				</a>
			 </div>
			
		{% else %}
			{{ post.content }}
		{% endif %}
		</div>
		{#####################}
		{### END POST BODY ###}
		{#####################}
		
		{% if not is_index %}
		  <!-- <div class="post-share">分享到：</div> -->
		  
		  {% if (theme.pay.alipay or theme.pay.wechatpay or theme.pay.bitcoin) %}
			  <div>
				{% include 'reward.swig' %}
			  </div>
		  {% endif %}
			
		  <footer class="post-footer">
				{% if post.tags and post.tags.length %}
				<div class="post-tags">
				  {% for tag in post.tags %}
					<a href="{{ url_for(tag.path) }}" rel="tag"># {{ tag.name }}</a>
				  {% endfor %}
				</div>
			    {% endif %}
				
				{% if not is_index and (post.prev or post.next) %}
				<div class="post-nav">
				  <div class="post-nav-next post-nav-item">
					{% if post.next %}
					  <a href="{{ url_for(post.next.path) }}" rel="next" title="{{ post.next.title }}">
						<i class="fas fa-angle-left"></i> {{ post.next.title }}
					  </a>
					{% endif %}
				  </div>

				  <span class="post-nav-divider"></span>

				  <div class="post-nav-prev post-nav-item">
					{% if post.prev %}
					  <a href="{{ url_for(post.prev.path) }}" rel="prev" title="{{ post.prev.title }}">
						{{ post.prev.title }} <i class="fas fa-angle-right"></i>
					  </a>
					{% endif %}
				  </div>
				</div>
			  {% endif %}
		  </footer>
		{% endif %}
		
	</div>
	{######################}
	{### END POST BLOCK ###}
	{######################}
	</article>
{% endmacro %}