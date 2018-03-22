<?php
$files = glob("*.*");
rsort($files);
echo "<ul>";
foreach($files as $filename) {
        if ($filename == "index.php") {
                continue;
        }
        echo "<li>";
        echo "<a href='";
        echo $filename;
        echo "'>".$filename."</a>";
        echo "<br>";
        echo "</li>";
}
echo "<ul>";