    inline = [
      "sudo apt-get install -y perl wget curl unzip make bsdmainutils tzdata",
      "sudo mkdir -p /data/spe/",
      "sudo ln -sfn /data/spe ${var.base_dir}/${var.org_dir}",
      "sudo chown -R ubuntu:ubuntu ${var.base_dir}/${var.org_dir}/",
      "sudo chmod 0700 /home/ubuntu/.ssh/",
      "sudo chmod 0600 /home/ubuntu/.ssh/id_rsa.${var.git_user_email}",
      "sudo chmod 0644 /home/ubuntu/.ssh/id_rsa.${var.git_user_email}.pub",
      "ssh-keyscan github.com >> ~/.ssh/known_hosts",
      "GIT_SSH_COMMAND='ssh -p 22 -oUserKnownHostsFile=/home/ubuntu/.ssh/known_hosts -i /home/ubuntu/.ssh/id_rsa.${var.git_user_email}' git clone git@github.com:${var.github_owner_org}/infra.git ${var.product_dir}",
      "GIT_SSH_COMMAND='ssh -p 22 -oUserKnownHostsFile=/home/ubuntu/.ssh/known_hosts -i /home/ubuntu/.ssh/id_rsa.${var.git_user_email}' git clone git@github.com:${var.github_owner_org}/spe-infra-conf.git ${var.product_dir}/cnf/env/spe/",
      "GIT_SSH_COMMAND='ssh -p 22 -oUserKnownHostsFile=/home/ubuntu/.ssh/known_hosts -i /home/ubuntu/.ssh/id_rsa.${var.git_user_email}' git clone git@github.com:${var.github_owner_org}/spe-e2e-mon.git ${var.base_dir}/${var.org_dir}/spe-e2e-mon",
      "cd ${var.product_dir} && git checkout 3009-add-the-infra-monitor-component-provisioning",
      "bash ${var.product_dir}/run -a do_ubuntu_check_install_docker",
      "cd ${var.base_dir}/${var.org_dir}/spe-e2e-mon && git checkout stg.env.yaml2944-add-reporting-of-deployed-backend-microservices-and-ui-versions-03",
      "make -C ${var.base_dir}/${var.org_dir}/spe-e2e-mon clean-install-infra-monitor-ui",
      "docker exec -it spe-e2e-mon-infra-monitor-ui-con /bin/bash -c \" ORG=${var.org} APP=${var.app} ENV=${var.env} ${var.base_dir}/${var.org_dir}/spe-e2e-mon/run -a do_check_install_npm_modules \""
    ]

  }
