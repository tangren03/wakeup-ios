#! /usr/bin/perl

# http://blog.csdn.net/learnios/article/details/8563777

open IN, "raw_city.txt";
open OUT, ">city.txt";

while (<IN>) {
  while (m/.+?:\d{9}/g) {
    print OUT $&, "\n";
  }
}

