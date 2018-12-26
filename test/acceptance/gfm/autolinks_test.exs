defmodule Acceptance.Gfm.AutolinksTest do
  use ExUnit.Case

  # import Support.GfmHelpers, only: [gfm: 1, no_gfm: 1]
  import Support.AssertionHelper

  describe "autolinks inside `<` & `>` (explicit autolinks)" do
    # GFM Example 580
    acceptance(
      "<http://foo.bar.baz>",
      ~s{<p><a href="http://foo.bar.baz">http://foo.bar.baz</a></p>}
    )

    acceptance(
      "<http://foo.bar.baz>",
      ~s{<p><a href="http://foo.bar.baz">http://foo.bar.baz</a></p>},
      gfm: false
    )

    # GFM Example 581
    acceptance(
      "<http://foo.bar.baz/test?q=hello&id=22&boolean>",
      ~s{<p><a href="http://foo.bar.baz/test?q=hello&amp;id=22&amp;boolean">http://foo.bar.baz/test?q=hello&amp;id=22&amp;boolean</a></p>}
    )

    acceptance(
      "<http://foo.bar.baz/test?q=hello&id=22&boolean>",
      ~s{<p><a href="http://foo.bar.baz/test?q=hello&amp;id=22&amp;boolean">http://foo.bar.baz/test?q=hello&amp;id=22&amp;boolean</a></p>},
      gfm: false
    )

    # GFM Example 582
    acceptance(
      "<irc://foo.bar:2233/baz>",
      ~s{<p><a href=\"irc://foo.bar:2233/baz\">irc://foo.bar:2233/baz</a></p>}
    )

    acceptance(
      "<irc://foo.bar:2233/baz>",
      ~s{<p><a href=\"irc://foo.bar:2233/baz\">irc://foo.bar:2233/baz</a></p>},
      gfm: false
    )

    # GFM Example 583
    acceptance(
      "<MAILTO:FOO@BAR.BAZ>",
      ~s{<p><a href=\"mailto:FOO@BAR.BAZ\">FOO@BAR.BAZ</a></p>},
      messages: [
        {:warning, 1,
         "DEPRECATION: Rendering a mailto link autolink will prepend `mailto:` to the text of the link in future versions"}
      ]
    )

    acceptance(
      "<MAILTO:FOO@BAR.BAZ>",
      ~s{<p><a href=\"mailto:FOO@BAR.BAZ\">FOO@BAR.BAZ</a></p>},
      gfm: false,
      messages: [
        {:warning, 1,
         "DEPRECATION: Rendering a mailto link autolink will prepend `mailto:` to the text of the link in future versions"}
      ]
    )

    # GFM Example 584
    acceptance(
      "<a+b+c:d>",
      ~s{<p><a+b+c:d></p>},
      messages: [
        {:warning, 1,
         "DEPRECATION: Although not a legal URL this will be rendered as a link with the `gfm` option set, according to `https://github.github.com/gfm/#example-584`"}
      ]
    )

    acceptance(
      "<a+b+c:d>",
      ~s{<p><a+b+c:d></p>},
      gfm: false
    )

    # GFM Example 585
    acceptance(
      "<made-up-scheme://foo,bar>",
      ~s{<p><a href="made-up-scheme://foo,bar">made-up-scheme://foo,bar</a></p>}
    )

    acceptance(
      "<made-up-scheme://foo,bar>",
      ~s{<p><a href="made-up-scheme://foo,bar">made-up-scheme://foo,bar</a></p>},
      gfm: false
    )

    # GFM Example 586
    acceptance(
      "<http://../>",
      ~s{<p><a href=\"http://../\">http://../</a></p>}
    )

    acceptance(
      "<http://../>",
      ~s{<p><a href=\"http://../\">http://../</a></p>},
      gfm: false
    )

    # GFM Example 587
    acceptance(
      "<localhost:5001/foo>",
      ~s{<p><localhost:5001/foo></p>},
      messages: [
        {:warning, 1,
         "DEPRECATION: As specified here `https://github.github.com/gfm/#example-587`, this is an autolink and will be rendered as a link in the next version"}
      ]
    )

    acceptance(
      "<localhost:5001/foo>",
      ~s{<p><localhost:5001/foo></p>},
      gfm: false
    )

    # GFM Example 588
    # Not a deprecation but a bugfix
    acceptance(
      "<http://foo.bar/baz bim>",
      ~s{<p>&lt;http://foo.bar/baz bim&gt;</p>}
    )

    acceptance(
      "<http://foo.bar/baz bim>",
      ~s{<p>&lt;http://foo.bar/baz bim&gt;</p>},
      gfm: false
    )

    # GFM Example 589
    # Not a deprecation but a bugfix
    acceptance(
      "<http://example.com/\[\>",
      ~s{<p><a href="http://example.com/%5C%5B%5C">http://example.com/\[\</a></p>
}
    )

    acceptance(
      "<http://example.com/\[\>",
      ~s{<p><a href="http://example.com/%5C%5B%5C">http://example.com/\[\</a></p>
      },
      gfm: false
    )

    # GFM Example 590
    acceptance(
      "<foo@bar.example.com>",
      ~s{<p><a href="mailto:foo@bar.example.com">foo@bar.example.com</a></p>}
    )

    acceptance(
      "<foo@bar.example.com>",
      ~s{<p><a href="mailto:foo@bar.example.com">foo@bar.example.com</a></p>},
      gfm: false
    )
  end
end

# SPDX-License-Identifier: Apache-2.0
