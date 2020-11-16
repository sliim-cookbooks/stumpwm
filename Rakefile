def bundle_exec(command)
  sh "bundle exec #{command}"
end

task :vendor do
  sh 'test -d cookbooks && rm -r cookbooks || exit 0'
  bundle_exec 'berks vendor cookbooks'
end

namespace :test do
  desc 'Tests suites runner'

  task :checkstyle do
    Rake::Task['test:cookstyle'].invoke
  end

  task :specs do
    Rake::Task['test:chefspec'].invoke
  end

  task :cookstyle do
    bundle_exec :cookstyle
  end

  task :chefspec do
    bundle_exec 'rspec spec --color --format documentation'
  end

  task :kitchen do
    bundle_exec 'kitchen test --concurrency'
  end
end

task default: ['test:checkstyle', 'test:specs']
