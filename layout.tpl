{PRESENT:}
	{data:showtitle}
	
	<div class="text-right"><a href="/{data.gallery}">{data.button}</a></div>
	{data.list::square}
{square:}
	{~odd(~key)?:galeven?:galodd}
	{galodd:}
	<div class="row">				
		<div class="col-sm-6 space">
			<div class="square-top"></div>
			<img class="img-responsive" src="/-imager/?src={...dir}{folder}/&w=800" alt="{title}">
		</div>
		<div class="col-sm-6 space">
			<div class="square-bot"></div>
			<h2 class="square-head">{title}</h2>
			<div class="space">{content}</div>
			<a class="btn btn-warning pull-left" href="/{...gallery}/{name}">{button|:Подробнее}</a>
			<div style="clear:both"></div>
		</div>
	</div>
	{galeven:}
	<div class="row square-even">
		<div class="col-sm-6 space col-sm-push-6">
			<div class="square-top"></div>
			<img class="img-responsive" src="/-imager/?src={...dir}{folder}/&w=800" alt="{title}">
		</div>
		<div class="col-sm-6 space col-sm-pull-6">
			<div class="square-bot"></div>
			<h2 class="square-head">{title}</h2>
			<div class="space">{content}</div>
			<a class="btn btn-warning pull-right" href="/{...gallery}/{name}">{button|:Подробнее}</a>
			<div style="clear:both"></div>
		</div>
		
	</div>
{PRESENTONE:}
	<div class="textInWorkExample photobank">
		<style scoped>
			.textInWorkExample .image {
				background-image:url('/-imager/?src={data.src}&w=1400'); 
				background-size:cover;
			}
			.textInWorkExample .text {
				padding: 50px;
				background: #f0f0f0;
			}
			.textInWorkExample .square {
			    width: 45px;
			    border-bottom:1px solid #ff9800;
			    position: relative;
			    margin-top: 50px;
			    margin-left:-50px;
			    margin-bottom:-50px;
			}
			.textInWorkExample .square:before {
				content: '';
			    position: absolute;
			    width: 11px;
			    height: 11px;
			    background: #ff9800;
			    -webkit-border-radius: 10px;
			    -moz-border-radius: 10px;
			    border-radius: 10px;
			    margin-top: -5px;
			    margin-left: 45px;
			    
			}
			
		</style>
		<table cellpadding="0" cellspacing="0" class="hidden-xs">
			<tr>
				<td class="image">
					<a style="display:block; height:500px; width:100%" href="/{data.gallery}/{data.name}"></a>
				</td>
				<td style="width:50%" class="text">
					<div class="exclamation">!</div>
					<h1>{data.title}</h1>
					<div class="line"></div>
					<div class="two-title">{data.lable}</div>
					<div class="square"></div>
					{data.list.0.title?:portheadsquare}
					<div class="space">
						{data.list.0.content|data.content}
					</div>
					<div class="text-center">
						<a class="btn btn-warning" href="/{data.gallery}/{data.name}">{data.button|:Подробнее}</a>
					</div>
				</td>
			</tr>
		</table>
		<div class="visible-xs">
			<div class="text">
				<div class="exclamation">!</div>
				<h1>Примеры работ</h1>
				<div class="line"></div>
				<div class="two-title">Индивидуальность в воплощении</div>
				{data.list.0.title?:porthead}
				<div class="space">
					{data.list.0.content|data.content}
				</div>
				<div class="text-center">
					<a class="btn btn-warning" href="/gallery/portfolio">Смотреть портфолио</a>
				</div>
			</div>
		</div>
	</div>
	{portheadsquare:}<h2 class="square-head">{data.list.0.title}</h2>
	{porthead:}<h2>{data.list.0.title}</h2>
{GALLERY:}
	{data:showtitle}
	
	
	<div class="row">
		{data.list::gal}
	</div>
	<p>{data.content}</p>
	<div class="space text-right" style="clear:both">
		<a href="/">На главную</a>
	</div>
	{gal:}
	<div class="col-lg-3 col-md-3 col-sm-6 text-center space">
		<div style="margin-bottom:10px;" class="panel panel-default">
			<div class="panel-body">{title}
				<span class="badge">{count}</span>
			</div>
		</div>
		
		<a class="thumbnail" style="margin-bottom:5px;" 
			href="/{...gallery}/{name}" title="{title}">
			<img class="img-responsive" src="/-imager/?src={data.dir}{folder}/&w=300&h=150&crop=1" alt="{title}">
		</a>
	</div>
{showtitle:}
		<h1>{title|data.title}</h1>
		{(lable|data.lable):%block}
	{%block:}<blockquote>{.}</blockquote>
{ONEGALLERY:}
	<div class="photobank">
		<style scoped>
			.photobank .mfp-bottom-bar {
				height: auto;
				background-color: #ebebeb;

			}
			.photobank .mfp-title {
				color: black;
				padding: 10px;
			}
		</style>
		{data:showtitle}
		<div class="row">
			{data.list::img}
		</div>
		<div class="space text-right" style="clear:both">
			<a href="/{data.gdata.gallery}">{data.gdata.button|:Галереи}</a>
		</div>
		
		<script>
			domready( function () {
				$('.image-popup-zoom').magnificPopup({
					type: 'inline',
					preloader: false,
					gallery: {
						enabled: true
					},
					callbacks: {
						change: function() {
							//Crumb.go(location.pathname+this.currItem.src);
							//location.hash = this.currItem.src;
							$(this.content).show();
						},
						beforeClose: function() {
							//location.hash = "";
							//Crumb.go(location.pathname);
							$(this.currItem.src).hide();
						}
					}
				});
				if (location.hash) {
					$('[href="'+location.hash+'"').click();
				}
				Event.onext('Crumb.onchange', function () {
					$.magnificPopup.instance.close();
				});
			});

		</script>
	</div>
	{img:}
	
		<div class="col-lg-3 col-md-3 col-sm-6 text-center">

			<a class="thumbnail image-popup-zoom" 
				title='{title|data.title}'
				rel="gallery"
				href="#ph-{~key}" data-ascroll="false" data-crumb="false" >
				<img class="img-responsive"  src="/-imager/?src={data.src}/{img}&w=300&h=300&crop=1">
			</a>
		</div>
		<div class="photobank" id="ph-{~key}" style="display:none; background-color:white; box-shadow: 0 0 10px rgba(0,0,0,0.2); padding:20px;">
			
			<div class="row">
				<div class="col-sm-6">
					<img class="img-responsive" src="/-imager/?src={data.src}/{img}&w=1200">
				</div>
				<div class="col-sm-6" style="padding-right:50px">
					{data:showtitle}
					{content|data.content}
				</div>
			</div>
		</div>
		

