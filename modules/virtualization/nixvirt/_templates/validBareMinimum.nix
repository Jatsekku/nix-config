# This is minimum nixvirt config that result in positive evaluation
# and service activation
{ ... }:
{
  name = "validBareMinimum";
  type = "kvm";
  uuid = "fbe91dfd-fdd9-2e31-1420-50ebf6599a91";

  memory = {
    count = 1;
    unit = "GiB";
  };

  os = {
    type = "hvm";
  };
}
