<!DOCTYPE html>
<html>
<head lang="{{ config.language }}">
	{% include '_partials/head.swig' %}
    <title>{% block title %}{% endblock %}</title>
	<script type="text/javascript" src={{ theme.vendors['disqusjs'] }}></script>
	<script type="text/javascript" src={{ theme.vendors['jquery'] }}></script>
</head>

<body>

	<div class="container">
		<header id="header">
			<div class="header-inner">
				<nav class="site-nav">
					{% if theme.menu %}
					<ul id="menu" class="menu">
						{% for name, path in theme.menu %}
							{% set itemName = name.toLowerCase() %}
							<li class="menu-item menu-item-{{ itemName | replace(' ', '-') }}">
								<a href="{{ url_for(trim(path.split('||')[0])) }}" rel="section"{% if path.split('||')[2] %} target="_blank"{% endif %}>
								{% if theme.menu_icons.enable %}
								  <i class="menu-item-icon {{ trim(path.split('||')[1]) }}"></i> <br />
								{% endif %}
								{{ __('menu.' + name) | replace('menu.', '') }}
								</a>
								{% if theme.submenu[itemName] %}
								<ul class="submenu submenu-{{ itemName | replace(' ', '-') }}">
								  {% for name, path in theme.submenu[itemName] %}
									{% set itemName = name.toLowerCase() %}
									<li class="submenu-item submenu-item-{{ itemName | replace(' ', '-') }}">
									  <a href="{{ trim(url_for(path)) }}" rel="section" target="_blank">
										{{ __('menu.' + name) | replace('menu.', '') }}
									  </a>
									</li>
								  {% endfor %}
								</ul>
							  {% endif %}
							</li>
						{% endfor %}
						
						{% if theme.search %}
						<li class="menu-item search">
						  <form class="search-form">
							<input name="keyword" type="text" class="search-input" placeholder="站内搜索">
							<button type="submit" class="search-submit"><i class="fas fa-search"></i></button>
						  </form>
						</li>
						{% endif %}
						{% if theme.online['users'] %}
						<li class="menu-item online"><span id="online-count">?</span>人在线</li>
						{% endif %}
					</ul>
					{% endif %}
				</nav>
				<div class="site-brand-wrapper">
					<div class="site-meta">
						<div class="custom-logo-site-title">
							<div class="brand">
								<span class="logo-line-before"><i></i></span>
								<div class="site-title">
									<div id="animate-stroke" class="animate">
									{% for letter in config.title %}{#
									  #}<span>
										  <svg>
											<use xlink:href="#stroke{{ letter }}"></use>
										  </svg>
										</span>{#
									#}{% endfor %}
									</div>
									<div id="animate" class="animate">
									{% for letter in config.title %}{#
									  #}<span>
										  <svg>
											<text id="stroke{{ letter }}">{{ letter }}</text>
										  </svg>
										</span>{#
									#}{% endfor %}
								  </div>
								  <div id="guide" class="guide">
									{% for letter in config.title %}{#
									  #}<span>{{ letter }}</span>{#
									#}{% endfor %}
								  </div>
								</div>
								 <span class="logo-line-after"><i></i></span>
							</div>
						</div>
					</div>
				</div>
				<div class="site-master" itemprop="author" itemscope itemtype="http://schema.org/Person">
					<img class="site-master-avatar scaleup" itemprop="image" src="{{ url_for( theme.avatar || '/images/aphage.png' ) }}" alt="{{ theme.author }}" />
					<h2 class="site-master-description scaleup" itemprop="description">
						{{ theme.description }}
					</h2>
				</div>
			</div>
		</header>
	
		<main id="main" class="main">
			<div class="main-inner">
				<div class="content-wrap">
				  <div id="content" class="content">
					{% block content %}{% endblock %}
				  </div>
				  {% include '_partials/comments.swig' %}
				</div>
				{% if theme.sidebar.display %}
				  {% block sidebar %}{% endblock %}
				{% endif %}
			  </div>
		</main>
		
		<footer id="footer" class="footer">
			<div class="footer-image"></div>
			<div class="footer-inner">
				{% include '_partials/footer.swig' %}
			</div>
		</footer>
	</div>
	
	<div id="aplayer-fixed"></div>
	
	<script type="text/javascript" src="/js/Level6.min.js?v={{ theme.version }}"></script>
	<script>
    var serviceWorkerUri = '/js/sw.js';
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register(serviceWorkerUri).then(function() {
          if (navigator.serviceWorker.controller) {
            console.log('Assets cached by the controlling service worker.');
          } else {
            console.log('Please reload this page to allow the service worker to handle network operations.');
          }
        }).catch(function(error) {
          console.log('ERROR: ' + error);
        });
    } else {
        console.log('Service workers are not supported in the current browser.');
    }
  </script>

</body>
</html>