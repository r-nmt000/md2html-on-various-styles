
use strict;
use warnings;

my $dependency_css1 = 'http://qiita.com/assets/application-1600cb4061f0a4667176a039b084954e.css';
my $dependency_css2 = 'https://a248.e.akamai.net/assets.github.com/assets/github-cfca8eb8e80a2c3bce67464f1c85defd532c0afd.css';
my $dependency_css3 = 'https://a248.e.akamai.net/assets.github.com/assets/github2-6fb37f4beb26b76fec8bcd25a34a112492a75cd5.css';


my @qiita_header = (
  "<!DOCTYPE html>"
, "<html lang='en'>"
, "<head>"
, "<meta charset='utf-8' />"
, "<link href='$dependency_css1' media='screen' rel='stylesheet' type='text/css' />"
, "</head>"
, "<body>"
, "<div id='container'>"
, "<div id='main' role='main'>"
, "<div id='left-column' class='item'>"
, "<article id='whole-item-content'>"
, "<section id='item-content' class='item-content-single' role='main'>"
);
my @qiita_footer = (
  "</section>"
, "</article>"
, "</div>"
, "</div>"
, "</div>"
, "</body>"
, "</html>"
);


my @github_header = (
  "<!DOCTYPE html>"
, "<html>"
, "<head>"
, "<meta charset='utf-8'>"
, "<link href='$dependency_css2' media='screen' rel='stylesheet' type='text/css' />"
, "<link href='$dependency_css3' media='screen' rel='stylesheet' type='text/css' />"
, "</head>"
, "<body class='logged_in  windows vis-public env-production '>"
, "<div id='wrapper'>"
, "<div class='site hfeed' itemscope itemtype='http://schema.org/WebPage'>"
, "<div class='hentry'>"
, "<div id='js-repo-pjax-container' class='container context-loader-container' data-pjax-container>"
, "<div id='slider'>"
, "<div class='frames'>"
, "<div class='frame' data-type='tree'>"
, "<div id='readme' class='clearfix announce instapaper_body md'>"
, "<span class='name'><span class='mini-icon mini-icon-readme'></span> README.md</span>"
, "<article class='markdown-body entry-content' itemprop='mainContentOfPage'>"
);
my @github_footer = (
  "</article>"
, "</div>"
, "</div>"
, "</div>"
, "<br style='clear:both;'>"
, "<br style='clear:both;'>"
, "</div>"
, "</div>"
, "</div>"
, "</div>"
, "</div>"
, "</div>"
, "</body>"
, "</html>"
);

my $md_filepath = $ARGV[0];
my $convert_type = $ARGV[1];

if( (-f $md_filepath) and ( ($convert_type =~ /qiita/) or ($convert_type =~ /github/) ) ){
  my @main = `perl ./dependency_files/Markdown.pl $md_filepath`;
  if ($convert_type =~ /qiita/){
    foreach my $line ((@qiita_header , @main , @qiita_footer)) {
      $line =~ s|<pre><code>|<div class='code-frame'><pre>|g;
      $line =~ s|</code></pre>|</pre></div>|g;
      print $line;
    }
  }
  if ($convert_type =~ /github/){
    foreach my $line ((@github_header , @main , @github_footer)) {
      print $line;
    }
  }
}
