#!/usr/bin/env perl

use strict;
use warnings;

use Test2::V0;

subtest "use" => sub {
  my $ok = lives {
    local $@;
    eval "use Text::AST::Builder";
    die $@ if $@
  };

  ok $ok, "Text::AST::Builder is loadable.";
};

done_testing;
