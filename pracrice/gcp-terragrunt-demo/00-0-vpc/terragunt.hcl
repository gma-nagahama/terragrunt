/**
 * https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#include
*/

include "root" {
    path = find_in_parent_folders()
}
