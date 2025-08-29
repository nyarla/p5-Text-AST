#!/usr/bin/env perl

use strict;
use warnings;

use Test2::V0;

subtest 'use Text::AST' => sub {
  my $succeed = lives {
    local $@;
    eval 'use Text::AST';
    die $@ if $@;
  };

  ok $succeed, "use Text::AST is succeed.";
};

done_testing;
