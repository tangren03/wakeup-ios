#! /usr/bin/perl

# http://blog.csdn.net/learnios/article/details/8563777

open IN, "raw_city.txt";
open OUT, ">city.txt";
open PLIST, ">city.plist";

my $head = <<END;
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
END

print PLIST $head;

while (<IN>) {
  while (m/.+?:\d{9}/g) {
    my $line = $&;
    print OUT $line, "\n";
    my @tok = split(/:/, $line);
    print PLIST "<key>".$tok[0]."</key>\n";
    print PLIST "<string>".$tok[1]."</string>\n";
  }
}

my $tail = <<END;
</dict>
</plist>
END

print PLIST $tail;

