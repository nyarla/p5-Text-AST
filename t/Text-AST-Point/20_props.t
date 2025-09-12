#!/usr/bin/env perl

use strict;
use warnings;

use Text::AST::Point;

use Test2::V0;

subtest 'ok' => sub {
  subtest 'get' => sub {
    my $point = Text::AST::Point->new( line => 1, column => 2 );

    is $point->line,   1, "Enable to get the 'line' property";
    is $point->column, 2, "Enable to get the 'column' property";
  };

  subtest 'set' => sub {
    my $point = Text::AST::Point->new( line => 1, column => 2 );

    is $point->line(3),   3, "Enable to set the 'line' property";
    is $point->column(4), 4, "Enable to set the 'column' property";
  };
};

subtest 'failure' => sub {
  subtest 'set malformed values' => sub {
    subtest 'undef' => sub {
      my $point = Text::AST::Point->new( line => 0, column => 0 );
      my $message;

      $message = dies {
        $point->line(undef);
      };

      like $message, qr/The argument was passed, but it's maybe undef/, "Can't set 'undef' to the 'line' property";

      $message = q{};

      $message = dies {
        $point->column(undef);
      };

      like $message, qr/The argument was passed, but it's maybe undef/, "Can't set 'undef' to the 'column' property";
    };

    subtest 'negative number' => sub {
      my $point = Text::AST::Point->new( line => 0, column => 0 );
      my $message;

      $message = dies {
        $point->line(-1);
      };

      like $message, qr/The argument should be 0 or larger integer/, "Can't set negative number to the 'line' property";

      $message = q{};

      $message = dies {
        $point->column(-1);
      };

      like $message, qr/The argument should be 0 or larger integer/, "Can't set negative number to the 'column' property";
    };

    subtest 'float' => sub {
      my $point = Text::AST::Point->new( line => 0, column => 0 );
      my $message;

      $message = dies {
        $point->line(0.01);
      };

      like $message, qr/The argument should be 0 or larger integer/, "Can't set float number to the 'line' property";

      $message = q{};

      $message = dies {
        $point->column(0.01);
      };

      like $message, qr/The argument should be 0 or larger integer/, "Can't set float number to the 'column' property";
    };

    subtest 'empty string' => sub {
      my $point = Text::AST::Point->new( line => 0, column => 0 );
      my $message;

      $message = dies {
        $point->line("");
      };

      like $message, qr/The argument should be 0 or larger integer/, "Can't set empty string to the 'line' property";

      $message = q{};

      $message = dies {
        $point->column("");
      };

      like $message, qr/The argument should be 0 or larger integer/, "Can't set empty string to the 'column' property";
    };

    subtest 'reference' => sub {
      my $point = Text::AST::Point->new( line => 0, column => 0 );
      my $message;

      $message = dies {
        $point->line( \"" );
      };

      like $message, qr/The argument should be 0 or larger integer/, "Can't set string reference to the 'line' property";

      $message = q{};

      $message = dies {
        $point->column( \"" );
      };

      like $message, qr/The argument should be 0 or larger integer/, "Can't set string reference to the 'column' property";
    };
  };
};

done_testing;
