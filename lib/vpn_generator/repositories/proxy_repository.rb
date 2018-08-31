class ProxyRepository < Hanami::Repository
  def create_if_uniq(ip:, port:)
      create(ip: ip, port: port) unless proxies.where(ip: ip, port: port).exist?
  end

  def get_fresh
    fresh.first.tap { |proxy| set_used(proxy.id) }
  end

  def set_used(id)
    update(id, used: true)
  end

  def fresh
    proxies.where(used: false)
  end
end
