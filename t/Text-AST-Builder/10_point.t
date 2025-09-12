#!/usr/bin/env perl

use strict;
use warnings;

use Text::AST::Builder qw(point);

use Test2::V0;

subtest 'point $x, $y' => sub {
  my $point = point 0, 10;

  isa_ok $point, 'Text::AST::Point';
  is $point->column, 0,  'The $x is column';
  is $point->line,   10, 'The $y is line';
};

done_testing;
