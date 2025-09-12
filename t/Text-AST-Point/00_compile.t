#!/usr/bin/env perl

use strict;
use warnings;

use Test2::V0;

subtest "use" => sub {
  my $ok = lives {
    local $@;
    eval "use Text::AST::Point";
    die $@ if $@
  };

  ok $ok, "Text::AST::Point is loadable.";
};

done_testing;
