# Terraform Module Lab — VNet in East US

A deliberately small project to make the **module** concept click.

## The mental model

A **module** is a reusable blueprint — like a function in code.

| Programming        | Terraform                          |
|--------------------|------------------------------------|
| Function           | Module (`./modules/network`)       |
| Function arguments | Input variables (`variables.tf`)   |
| Function body      | The resources (`main.tf`)          |
| Return value       | Outputs (`outputs.tf`)             |
| Calling a function | A `module "xyz" { ... }` block     |

The **root** (the files in the top folder) doesn't create resources itself.
It *calls* the module and passes in inputs. Calling the same module twice
with different inputs gives you two independent stacks — that's the payoff.

## Layout

```
terraform-module-lab/
├── providers.tf          # azurerm provider + version pins
├── main.tf               # ROOT: calls the network module
├── variables.tf          # ROOT: shared tags
├── outputs.tf            # ROOT: surfaces the module's outputs
└── modules/
    └── network/          # THE MODULE (the reusable blueprint)
        ├── main.tf        # resources: RG + VNet + subnets
        ├── variables.tf   # the module's "inputs"
        └── outputs.tf     # the module's "return values"
```

## Run it

```bash
# 1. Point Terraform at your subscription (you already did `az login`)
export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)

# 2. Standard loop
terraform init      # downloads azurerm + registers the local module
terraform plan      # preview: 1 RG, 1 VNet, 2 subnets
terraform apply     # type 'yes' to build

# 3. When done playing
terraform destroy
```

## Experiments (this is the "play with it" part)

1. **See reusability.** Uncomment the `vnet_westus` block in `main.tf`
   (and the matching output in `outputs.tf`), then `terraform plan`.
   One module, called twice → a whole second stack in another region.
   That single idea is 90% of why modules exist.

2. **Watch `for_each` work.** Add a third subnet to the East US `subnets`
   map, e.g. `"snet-mgmt" = "10.10.3.0/24"`, and re-plan. The module
   loops over whatever map you give it — you never edited the module.

3. **Trace an output up the chain.** Run `terraform output`. The value
   started as a resource attribute *inside* the module, was exposed by
   the module's `outputs.tf`, then re-exposed by the root's `outputs.tf`.
   A caller can only see what a module deliberately outputs.

4. **Inspect interactively.** Run `terraform console`, then type
   `module.vnet_eastus.subnet_ids` to poke at module outputs live.

5. **Break it on purpose.** In the root `main.tf`, remove the
   `address_space` line and run `plan`. Terraform errors because the
   module *requires* that input (no default). That's the module
   enforcing its own contract.

## Real-world note

This module creates its own resource group so each call is fully
self-contained — great for learning. In a real hub-and-spoke setup
you'd often pass in an *existing* RG name instead, and split the module
into smaller pieces (a vnet module, a subnet module, a peering module)
that get composed together. Same concept, more layers.
