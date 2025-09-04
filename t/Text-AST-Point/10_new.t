#!/usr/bin/env perl

use strict;
use warnings;

use Text::AST::Point;

use Test2::V0;

subtest 'ok' => sub {
  subtest '($key => $value)' => sub {
    my $point = Text::AST::Point->new( line => 0, column => 0 );
    isa_ok $point, 'Text::AST::Point';
  };

  subtest '{ $key => $value }' => sub {
    my $point = Text::AST::Point->new( { line => 0, column => 0 } );
    isa_ok $point, 'Text::AST::Point';
  };
};

subtest 'failure' => sub {
  subtest 'malformed number' => sub {
    subtest 'negative number' => sub {
      my $message = dies {
        my $point = Text::AST::Point->new( line => -1, column => 0 );
      };

      like $message, qr/The argument 'line' is not 0 or larger number/, 'Cannot pass negative number value';
    };

    subtest 'flaot' => sub {
      my $message = dies {
        my $point = Text::AST::Point->new( line => 0, column => 0.01 );
      };

      like $message, qr/The argument 'column' is not 0 or larger number/, 'Cannot pass float number';
    };

    subtest 'non number' => sub {
      my $message = dies {
        my $point = Text::AST::Point->new( line => 0, column => "zero" );
      };

      like $message, qr/The argument 'column' is not 0 or larger number/, 'Cannot pass non number object';
    };

    subtest 'empty string' => sub {
      my $message = dies {
        my $point = Text::AST::Point->new( line => 0, column => "" );
      };

      like $message, qr/The argument 'column' is not 0 or larger number/, 'Cannot pass non number object';
    };
  };

  subtest 'missing arguments' => sub {
    subtest 'line is missing' => sub {
      my $message = dies {
        my $point = Text::AST::Point->new( column => 0 );
      };

      like $message, qr/The 'line' is missing. this argument always required./, 'Cannot accept missing to line';
    };

    subtest 'column is missing' => sub {
      my $message = dies {
        my $point = Text::AST::Point->new( line => 0 );
      };

      like $message, qr/The 'column' is missing. this argument always required./, 'Cannot accept missing to column';
    };
  };

  subtest 'malformed arguments' => sub {
    subtest 'unsupported reference' => sub {
      subtest 'ArrayRef' => sub {
        my $message = dies {
          my $point = Text::AST::Point->new( [] );
        };

        like $message, qr/Unsupported arguments. the arguments shoule be HASH reference or key-value pair/,
            'Cannot pass unsupported value';
      };

      subtest 'ScalarRef' => sub {
        my $message = dies {
          my $point = Text::AST::Point->new( \"" );
        };

        like $message, qr/Unsupported arguments. the arguments shoule be HASH reference or key-value pair/,
            'Cannot pass unsupported value';
      };
    };

    subtest 'unsupported values' => sub {
      subtest 'single value' => sub {
        my $message = dies {
          my $point = Text::AST::Point->new("");
        };

        like $message, qr/Unsupported arguments. the arguments shoule be HASH reference or key-value pair/,
            'Cannot pass unsupported value';
      };

      subtest 'unmatched pairs' => sub {
        my $message = dies {
          my $point = Text::AST::Point->new( line => 0, column => 0, 1 );
        };

        like $message, qr/Unsupported arguments. the arguments shoule be HASH reference or key-value pair/,
            'Cannot pass unsupported value';
      };

      subtest 'unsupported properties' => sub {
        my $message = dies {
          my $point = Text::AST::Point->new( line => 0, column => 0, foo => 0 );
        };

        like $message, qr/The arguments has unsupported property keys: foo/, "Cannot pass unsupported property";
      };
    };
  };
};

done_testing;
