<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GameOn.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Slider" runat="server">
    <div class="index-banner">
        <div class="index-banner-2">
       	  <div class="wmuSlider example1" style="height: 560px;">
			  <div class="wmuSliderWrapper">
				  <article style="position: relative; width: 100%; opacity: 1;"> 
				   	<div class="banner-wrap">
					   	<div class="slider-left">

							<img src="images/slider1.png" alt=""/> 
						</div>
						 <div class="slider-right">
						    <h1>Ultra</h1>
						    <h2>Yuvi</h2>
						    <p>World Record of 6 SIXES !</p>
						    <div class="btn"><a href="shop.aspx">Shop Now</a></div>
						 </div>
						 <div class="clear"></div>
					 </div>
					</article>
				   <article style="position: absolute; width: 100%; opacity: 0;"> 
				   	 <div class="banner-wrap">
					   	<div class="slider-left">
							<img src="images/slider2.png" alt=""/> 
						</div>
						 <div class="slider-right">
						    <h1>ULTRA</h1>
						    <h2>Running</h2>
						    <p>Explore our running series</p>
						    <div class="btn"><a href="shop.aspx">Shop Now</a></div>
						 </div>
						 <div class="clear"></div>
					 </div>
				   </article>
				   <article style="position: absolute; width: 100%; opacity: 0;">
				   	<div class="banner-wrap">
					   	<div class="slider-left">
							<img src="images/slider3.png" alt=""/> 
						</div>
						 <div class="slider-right">
						    <h1>Captain</h1>
						    <h2>Cool</h2>
						    <p>Best Finisher in the World</p>
						    <div class="btn"><a href="shop.aspx">Shop Now</a></div>
						 </div>
						 <div class="clear"></div>
					 </div>
				   </article>
				   <article style="position: absolute; width: 100%; opacity: 0;">
				   	<div class="banner-wrap">
					   	<div class="slider-left">
							<img src="images/slider4.png" alt=""/> 
						</div>
						 <div class="slider-right">
						    <h2>Boom Boom</h2>
						    <h2>Afridi</h2>
						    <p>Best Shot 'Anywhere' for SIX</p>
						    <div class="btn"><a href="shop.aspx">Shop Now</a></div>
						 </div>
						 <div class="clear"></div>
					 </div>
				   </article>
                   <article style="position: absolute; width: 100%; opacity: 0;">
				   	<div class="banner-wrap">
					   	<div class="slider-left">
							<img src="images/slider5.png" alt=""/> 
						</div>
						 <div class="slider-right">
						    <h1>Gangnam</h1>
						    <h2>Gayle</h2>
						    <p>Highest Strike Rate : 185.75</p>
						    <div class="btn"><a href="shop.aspx">Shop Now</a></div>
						 </div>
						 <div class="clear"></div>
					 </div>
				   </article>
				</div>
                <a class="wmuSliderPrev">Previous</a><a class="wmuSliderNext">Next</a>
                <ul class="wmuSliderPagination">
                	<li><a href="#" class="">0</a></li>
                	<li><a href="#" class="">1</a></li>
                	<li><a href="#" class="wmuActive">2</a></li>
                	<li><a href="#">3</a></li>
                	<li><a href="#">4</a></li>
                  </ul>
                 <a class="wmuSliderPrev">Previous</a><a class="wmuSliderNext">Next</a><ul class="wmuSliderPagination"><li><a href="#" class="wmuActive">0</a></li><li><a href="#" class="">1</a></li><li><a href="#" class="">2</a></li><li><a href="#" class="">3</a></li><li><a href="#" class="">4</a></li></ul></div>
            	 <script src="js/jquery.wmuSlider.js"></script> 
				 <script type="text/javascript" src="js/modernizr.custom.min.js"></script> 
						<script>
						    $('.example1').wmuSlider();
   						</script> 	           	      
             </div></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Products" runat="server">
     
    <div id="mainContent" runat="server" class="container-fluid">
    </div>
</asp:Content>